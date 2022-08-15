//
//  File Name     : ChatDataService.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/7/20 00:34.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import Firebase
import Foundation

class ChatDataService {
    private static let db = FirebaseManager.shared.firestore.collection("chats")
    private static var listener: Firebase.ListenerRegistration?

    // (Steve X): REMOVE BEFORE FLIGHT TODO: remove `users`, `sample`
    static let users: [User] = UserDataService.sample
    static let sample: [Chat] = [
        Chat(
            users: [users[0].id, users[1].id],
            messages: MessageDataService.sample
        ),
    ]

    /// Write data into Firebase FireStore
    /// - Parameter chat: Chat instance
    static func add(for chat: Chat) {
        let document = db.document(chat.id)
        let keySaltB64Str: String = (chat.keySalt ?? CryptoManager.saltGen()).base64EncodedString()

        // Encode DicKeys into enum type
        let data: [DicKeyManager.ChatDicKey: Any] = [
            .id: chat.id,
            .users: chat.users,
            .messages: chat.messages,
            .keySaltB64Str: keySaltB64Str,
        ]

        // Decode DicKeys into rawValue String
        let decodedData = data.mapKeys { $0.rawValue }

        document.setData(decodedData) { error in
            if let error = error {
                print(error)
            }
        }
    }

    /// Refresh chats from Firebase FireStore automatically at real time
    /// - Parameter vm: MessageListViewModel
    static func fetchRealTime(vm: MessageListViewModel) {
        guard let myID = UserAuthManager.currentUser?.uid else { return }

        listener = db.whereField("users", arrayContains: myID).addSnapshotListener { query, error in
            if let error = error {
                print(error)
            }

            if let query = query {
                query.documentChanges.forEach { change in
                    if change.type == .added {
                        // Encode DicKeys into enum type
                        let data = change.document.data().mapKeys { DicKeyManager.ChatDicKey(rawValue: $0) }
                        let new_chat = Chat(
                            id: data[.id] as? String ?? "",
                            users: data[.users] as? [User.ID] ?? [],
                            messages: data[.messages] as? [Message] ?? [],
                            keySalt: Data(base64Encoded: data[.keySaltB64Str] as? String ?? "")
                        )

                        vm.chats.append(new_chat)
                    } else if change.type == .removed {
                        let data = change.document.data().mapKeys { DicKeyManager.ChatDicKey(rawValue: $0) }
                        vm.chats.removeAll { $0.id == data[.id] as? String }
                    }
                }
            }
        }
    }

    /// Remove Firebase Firestore listener
    static func unsubscribe() {
        listener?.remove()
    }

    /// Derivate shared symmetric secret key with other user for chat using specific salt.
    /// If salt for this chat does not exist in DB, generate a new salt and then publish to DB.
    /// - Parameters:
    ///   - userID: ID of target user
    ///   - chatID: ID of chat
    ///   - size: The length in bytes of resulting symmetric key
    /// - Returns: Salt `Data` for generating this key or `nil` if failed.
    static func symKeyGen(
        with userID: User.ID,
        for chatID: Chat.ID,
        size: Int = 256
    ) async -> Data? {
        guard let pubKeyB64Str = await PublicKeyDataService.fetchPubKeyB64Str(for: userID) else { return nil }

        // Fetch salt from DB
        guard let dataDict = try? await
            db
            .document(chatID)
            .getDocument()
            .data()
        else {
            print("Fail to fetch data for ChatID: [\(chatID)]")
            return nil
        }

        let data = dataDict.mapKeys { DicKeyManager.ChatDicKey(rawValue: $0) }
        var salt: Data
        if let keySaltB64Str = data[.keySaltB64Str] as? String {
            salt = Data(base64Encoded: keySaltB64Str) ?? CryptoManager.saltGen()
        } else {
            salt = CryptoManager.saltGen()
        }

        saltPublish(salt: salt, for: chatID)
        guard CryptoManager.symKeyDerivation(with: pubKeyB64Str, for: chatID, size: size, salt: salt) else { return nil }

        return salt
    }

    /// Update salt for specific chat
    /// - Parameters:
    ///   - salt: salt data
    ///   - chatID: ID of target chat
    static func saltPublish(salt: Data, for chatID: Chat.ID) {
        let saltB64Str = salt.base64EncodedString()
        let document = db.document(chatID)

        // Encode DicKeys into enum type
        let data: [DicKeyManager.ChatDicKey: Any] = [
            .keySaltB64Str: saltB64Str,
        ]

        // Decode DicKeys into rawValue String
        let decodedData = data.mapKeys { $0.rawValue }

        document.updateData(decodedData)
    }
}
