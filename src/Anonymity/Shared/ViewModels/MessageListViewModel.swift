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
        chats = ChatDataService.chats
    }

    func addChat(by creator: User.ID, with persons: [User.ID]) {
        let new_chat = Chat(by: creator, with: persons)

        // Create new chats only when it doesn't exist
        if chats.first(where: { $0.id == new_chat.id }) == nil {
            chats.append(new_chat)
            ChatDataService.addChat(for: new_chat)
        }
    }
}
