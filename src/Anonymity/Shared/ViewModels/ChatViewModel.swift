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
//    @Published var chat: Chat
    @Published var messages: [Message]

    init() {
        // TODO: (Steve X): REMOVE BEFORE FLIGHT: set custom id
//        chat = ChatDataService.chats[0]
        messages = MessageDataService.messages
    }

    func sendMessage(
        chatId: Chat.ID,
        type: Message.MessageType,
        senderID: String = UserAuthManager.currentUser?.uid ?? "",
        content: String,
        timestamp: Date = .now,
        isReceived: Bool = false
    ) {
        let new_message = Message(
            chatID: chatId,
            type: type,
            senderID: senderID,
            content: content,
            timestamp: timestamp,
            isReceived: isReceived
        )

//        chat.messages.append(new_message)
        MessageDataService.add(in: chatId, for: new_message)
    }

    func autoRefreshChat(chatID: Chat.ID) {
        MessageDataService.fetchRealTime(in: chatID, vm: self)
    }
}
