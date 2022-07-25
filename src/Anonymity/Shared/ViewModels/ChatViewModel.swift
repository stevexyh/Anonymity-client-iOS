//
//  File Name     : ChatViewModel.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/7/25 20:55.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var chats: [Chat]

    init() {
        chats = ChatDataService.chats
    }

    func addMessage(
        chatId: Int,
        type: Message.MessageType,
        sender: User, receiver: User,
        content: String,
        timestamp: Date = .now,
        isReceived: Bool = false,
        digest: String = "<digest>"
    ) {
        let new_message = Message(
            type: type,
            sender: sender,
            content: content,
            timestamp: timestamp,
            isReceived: isReceived,
            digest: digest
        )
        chats[chatId].messages.append(new_message)
    }
}
