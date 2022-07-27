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
                Message(type: .received, sender: users[1], content: "test message", timestamp: .now, isReceived: true),
                Message(type: .sent, sender: users[0], content: "test message", timestamp: .now, isReceived: true),
                Message(type: .received, sender: users[1], content: "test message", timestamp: .now, isReceived: true),
                Message(type: .received, sender: users[1], content: "test message", timestamp: .now, isReceived: true),
                Message(type: .sent, sender: users[0], content: "test message", timestamp: .now, isReceived: true),
            ]
        ),
    ]

    static func addChat(for chat: Chat) {
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
}
