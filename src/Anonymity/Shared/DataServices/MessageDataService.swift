//
//  File Name     : MessageDataService.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/7/5 16:45.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import Firebase
import Foundation

class MessageDataService {
    private static let db = FirebaseManager.shared.firestore.collection("chats")
    private static var listener: Firebase.ListenerRegistration?

    // (Steve X): REMOVE BEFORE FLIGHT TODO: remove `users`, `sample`
    static let users: [User] = UserDataService.sample
    static let sample: [Message] = [
        Message(chatID: "0", type: .received, senderID: users[1].id, content: "test message", timestamp: .now, isReceived: true),
        Message(chatID: "0", type: .sent, senderID: users[0].id, content: "test message", timestamp: .now, isReceived: true),
        Message(chatID: "0", type: .received, senderID: users[1].id, content: "test message", timestamp: .now, isReceived: true),
        Message(chatID: "0", type: .received, senderID: users[1].id, content: "test message", timestamp: .now, isReceived: true),
        Message(chatID: "0", type: .sent, senderID: users[0].id, content: "test message", timestamp: .now, isReceived: true),
    ]

    /// Write data into Firebase FireStore
    /// - Parameters:
    ///   - chatID: ID of chat instance
    ///   - message: message instance
    static func add(in chatID: Chat.ID, for message: Message) {
        let cipherText = CryptoManager.symEncrypt(for: message.content, in: chatID)
        let document = db.document(chatID).collection("messages").document(message.id)
        let data: [DicKeyManager.MessageDicKey: Any] = [
            .id: message.id,
            .chatID: message.chatID,
            .senderID: message.senderID,
            .content: cipherText ?? message.content,
            .timestamp: message.timestamp,
            .isReceived: message.isReceived,
            .isEncrypted: cipherText != nil,
            .digest: message.digest,
        ]

        // Decode DicKeys into rawValue String
        let decodedData = data.mapKeys { $0.rawValue }

        document.setData(decodedData) { error in
            if let error = error {
                print(error)
            }
        }
    }

    /// Refresh messages from Firebase FireStore automatically at real time
    /// - Parameter vm: ChatViewModel
    static func fetchRealTime(vm: ChatViewModel) {
        guard let myID = UserAuthManager.currentUser?.uid else { return }

        listener = FirebaseManager.shared.firestore.collectionGroup("messages")
            .addSnapshotListener { query, error in
                if let error = error {
                    print(error)
                }

                if let query = query {
                    query.documentChanges.forEach { change in
                        if change.type == .added {
                            // Encode DicKeys into enum type
                            let data = change.document.data().mapKeys { DicKeyManager.MessageDicKey(rawValue: $0) }
                            let timestamp = data[.timestamp] as? Timestamp ?? Timestamp(seconds: 0, nanoseconds: 0)
                            let chatID = data[.chatID] as? String ?? ""
                            let senderID = data[.senderID] as? String ?? ""
                            let isEncrypted = data[.isEncrypted] as? Bool ?? false

                            let content = data[.content] as? String ?? ""
                            let plainText = isEncrypted ? CryptoManager.symDecrypt(from: content, in: chatID) : content

                            let new_message = Message(
                                id: data[.id] as? String ?? "",
                                chatID: chatID,
                                type: myID == senderID ? .sent : .received,
                                senderID: senderID,
                                content: plainText ?? "",
                                timestamp: timestamp.dateValue(),
                                isEncrypted: isEncrypted
                            )

                            // Append new message to VM dict only once, default value is empty array if key does not exists
                            if vm.messages[new_message.chatID]?.first(where: { $0.id == new_message.id }) == nil {
                                vm.messages[new_message.chatID, default: []].append(new_message)
                            }
                        } else if change.type == .removed {
                            let data = change.document.data().mapKeys { DicKeyManager.MessageDicKey(rawValue: $0) }
                            vm.messages[data[.chatID] as? Chat.ID ?? ""]?.removeAll { $0.id == data[.id] as? String }
                        }
                    }
                }
            }
    }

    /// Remove Firebase Firestore listener
    static func unsubscribe() {
        listener?.remove()
    }
}
