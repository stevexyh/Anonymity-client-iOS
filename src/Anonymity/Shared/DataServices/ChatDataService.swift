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
    static let users: [User] = UserDataService.users
    static let chats: [Chat] = [
        Chat(
            type: .single,
            person: [users[0], users[1]],
            messages: [
                Message(type: .received, sender: users[1], content: "test message", timestamp: .now, isReceived: true, digest: "abcabc"),
                Message(type: .sent, sender: users[0], content: "test message", timestamp: .now, isReceived: true, digest: "abcabc"),
                Message(type: .received, sender: users[1], content: "test message", timestamp: .now, isReceived: true, digest: "abcabc"),
                Message(type: .received, sender: users[1], content: "test message", timestamp: .now, isReceived: true, digest: "abcabc"),
                Message(type: .sent, sender: users[0], content: "test message", timestamp: .now, isReceived: true, digest: "abcabc"),
            ]
        ),
    ]
}
