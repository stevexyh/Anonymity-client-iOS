//
//  File Name     : MessageListViewModel.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/7/20 00:47.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import Foundation

class MessageListViewModel: ObservableObject {
    @Published var chats: [Chat]

    init() {
        chats = []
    }

    func addChat(by creator: User.ID, with persons: [User.ID]) async {
        var new_chat = Chat(by: creator, with: persons)

        // Create new chats only when it doesn't exist
        if chats.first(where: { $0.id == new_chat.id }) == nil {
            ChatDataService.add(for: new_chat)
        }

        if await encryptChat(with: persons[0], for: new_chat.id) {
            new_chat.isEncrypted = true
        }
    }

    func autoRefreshChat() {
        chats.removeAll()
        ChatDataService.fetchRealTime(vm: self)
        PublicKeyDataService.publish()
    }

    /// Generate symmetric key for encrypting a chat.
    /// - Parameters:
    ///   - userID: ID of target user
    ///   - chatID: ID of chat
    ///   - size: The length in bytes of resulting symmetric key
    /// - Returns: A boolean indicates success / failure
    func encryptChat(with userID: User.ID, for chatID: Chat.ID, size: Int = 256) async -> Bool {
        let res = await ChatDataService.symKeyGen(with: userID, for: chatID, size: size) != nil
        if let id = chats.firstIndex(where: { $0.id == chatID }) {
            chats[id].isEncrypted = true
        }

        return res
    }
}
