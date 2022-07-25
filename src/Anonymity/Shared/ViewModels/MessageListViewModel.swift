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

    func addChat(type: Chat.ChatType, person: [User]) {
        let new_chat = Chat(type: type, person: person, messages: [])
        chats.append(new_chat)
    }
}
