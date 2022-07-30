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
    static let users: [User] = UserDataService.users
    static let chats: [Chat] = [
        Chat(
            users: [users[0].id, users[1].id],
            messages: [
                Message(type: .received, senderID: users[1].id, content: "test message", timestamp: .now, isReceived: true),
                Message(type: .sent, senderID: users[0].id, content: "test message", timestamp: .now, isReceived: true),
                Message(type: .received, senderID: users[1].id, content: "test message", timestamp: .now, isReceived: true),
                Message(type: .received, senderID: users[1].id, content: "test message", timestamp: .now, isReceived: true),
                Message(type: .sent, senderID: users[0].id, content: "test message", timestamp: .now, isReceived: true),
            ]
        ),
    ]

    static func add(for chat: Chat) {
        let document = db.document(chat.id)
        let data: [String: Any] = [
            "id": chat.id,
            "users": chat.users,
            "messages": chat.messages,
        ]

        document.setData(data) { error in
            if let error = error {
                print(error)
            }
        }
    }

    static func fetchRealTime(vm: MessageListViewModel) {
        db.addSnapshotListener { query, error in
            if let error = error {
                print(error)
            }

            if let query = query {
                query.documentChanges.forEach { change in
                    if change.type == .added {
                        let data = change.document.data()
                        let new_chat = Chat(
                            id: data["id"] as? String ?? "",
                            users: data["users"] as? [User.ID] ?? [],
                            messages: data["messages"] as? [Message] ?? []
                        )

                        vm.chats.append(new_chat)
                    } else if change.type == .removed {
                        let data = change.document.data()
                        vm.chats.removeAll { $0.id == data["id"] as? String }
                    }
                }
            }
        }
    }
}
