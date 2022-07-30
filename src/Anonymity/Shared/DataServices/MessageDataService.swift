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
        Message(type: .received, senderID: users[1].id, content: "test message", timestamp: .now, isReceived: true),
        Message(type: .sent, senderID: users[0].id, content: "test message", timestamp: .now, isReceived: true),
        Message(type: .received, senderID: users[1].id, content: "test message", timestamp: .now, isReceived: true),
        Message(type: .received, senderID: users[1].id, content: "test message", timestamp: .now, isReceived: true),
        Message(type: .sent, senderID: users[0].id, content: "test message", timestamp: .now, isReceived: true),
    ]

    static func add(in chatID: Chat.ID, for message: Message) {
        let document = db.document(chatID).collection("messages").document(message.id)
        let data: [String: Any] = [
            "id": message.id,
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
}
