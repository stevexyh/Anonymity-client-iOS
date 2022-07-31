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

import Foundation

class MessageDataService {
    static let db = FirebaseManager.shared.firestore.collection("chats")

    static let users: [User] = UserDataService.users
    static let messages: [Message] = [
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
        let document = db.document(chatID).collection("messages").document(message.id)
        let data: [String: Any] = [
            "id": message.id,
            "chatID": message.chatID,
            "senderID": message.senderID,
            "content": message.content,
            "timestamp": message.timestamp,
            "isReceived": message.isReceived,
            "digest": message.digest,
        ]

        document.setData(data) { error in
            if let error = error {
                print(error)
            }
        }
    }

    // FIXME: (Steve X): show messages in all chats -> only in current chat
    /// Refresh messages from Firebase FireStore automatically at real time
    /// - Parameter vm: ChatViewModel
    static func fetchRealTime(in chatID: Chat.ID, vm: ChatViewModel) {
        guard let myID = UserAuthManager.currentUser?.uid else { return }
        db.document(chatID)
            .collection("messages")
            .addSnapshotListener { query, error in
                if let error = error {
                    print(error)
                }

                if let query = query {
                    query.documentChanges.forEach { change in
                        if change.type == .added {
                            // TODO: (Steve X): Encode DicKeys into enum type
                            // Encode DicKeys into enum type
                            let data = change.document.data() // .mapKeys { DicKeyManager.MessageDicKey(rawValue: $0) }
                            let new_message = Message(
                                id: data["id"] as? String ?? "",
                                chatID: data["chatID"] as? String ?? "",
                                type: myID == (data["senderID"] as? String ?? "") ? .sent : .received,
                                senderID: data["senderID"] as? String ?? "",
                                content: data["content"] as? String ?? "",
                                timestamp: data["timestamp"] as? Date ?? Date(timeIntervalSince1970: 0)
                            )

                            if vm.messages.first(where: { $0.id == new_message.id }) == nil {
                                vm.messages.append(new_message)
                            }
                        } else if change.type == .removed {
                            let data = change.document.data() // .mapKeys { DicKeyManager.MessageDicKey(rawValue: $0) }
                            vm.messages.removeAll { $0.id == data["id"] as? String }
                        }
                    }
                }
            }
    }
}
