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
    static let users: [User] = UserDataService.users
    static let messages: [Message] = [
        Message(type: .received, sender: users[1], receiver: users[0], content: "test message", timestamp: .now, isReceived: true, digest: "abcabc"),
        Message(type: .sent, sender: users[0], receiver: users[1], content: "test message", timestamp: .now, isReceived: true, digest: "abcabc"),
        Message(type: .received, sender: users[1], receiver: users[0], content: "test message", timestamp: .now, isReceived: true, digest: "abcabc"),
        Message(type: .received, sender: users[1], receiver: users[0], content: "test message", timestamp: .now, isReceived: true, digest: "abcabc"),
        Message(type: .sent, sender: users[0], receiver: users[1], content: "test message", timestamp: .now, isReceived: true, digest: "abcabc"),
    ]
}
