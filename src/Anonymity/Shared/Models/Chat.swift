//
//  File Name     : Chat.swift
//  Project Name  : Anonymity
//  Description   : Chat model with single or multiple users
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/6/28 17:37.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import Foundation

struct Chat: Identifiable {
    let id = UUID()
    let type: ChatType
    var person: [User]
    var messages: [Message]
}

extension Chat {
    enum ChatType {
        case single
        case group
    }
}
