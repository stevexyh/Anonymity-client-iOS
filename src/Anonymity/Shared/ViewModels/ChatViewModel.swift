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
    @Published var chat: Chat

    init() {
        // TODO: (Steve X): REMOVE BEFORE FLIGHT: set custom id
        chat = ChatDataService.chats[0]
    }

    func sendMessage(
        chatId: Int,
        type: Message.MessageType,
        senderID: String,
        content: String,
        timestamp: Date = .now,
        isReceived: Bool = false,
        digest: String = "<digest>"
    ) {
        let new_message = Message(
            type: type,

            // TODO: (Steve X): REMOVE BEFORE FLIGHT: set default value
            sender: UserDataService.users.first(where: { $0.id == senderID }) ?? UserDataService.users[0],
            content: content,
            timestamp: timestamp,
            isReceived: isReceived,
            digest: digest
        )
        chat.messages.append(new_message)
    }
}
