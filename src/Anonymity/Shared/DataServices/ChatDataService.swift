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

import Foundation

class ChatDataService {
    static let db = FirebaseManager.shared.firestore.collection("chats")
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

        // Encode DicKeys into enum type
        let data: [DicKeyManager.ChatDicKey: Any] = [
            .id: chat.id,
            .users: chat.users,
            .messages: chat.messages,
            .keySaltB64Str: chat.keySalt?.base64EncodedString() ?? "",
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
        db.whereField("users", arrayContains: myID).addSnapshotListener { query, error in
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
}
