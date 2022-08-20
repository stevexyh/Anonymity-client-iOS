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
    @Published var messages: [Chat.ID: [Message]]

    init() {
        messages = [:]
    }

    func sendMessage(
        chatId: Chat.ID,
        type: Message.ReceiveType,
        senderID: String = UserAuthManager.currentUser?.uid ?? "",
        contentType: Message.ContentType,
        content: String,
        timestamp: Date = .now,
        isReceived: Bool = false
    ) {
        let new_message = Message(
            chatID: chatId,
            type: type,
            contentType: contentType,
            senderID: senderID,
            content: content,
            timestamp: timestamp,
            isReceived: isReceived
        )

        MessageDataService.add(in: chatId, for: new_message)
    }

    func autoRefreshChat() {
        messages.removeAll()
        MessageDataService.fetchRealTime(vm: self)
    }

    func getLatestMessage(in chatID: Chat.ID) -> Message? {
        return messages[chatID]?.last
    }
}
