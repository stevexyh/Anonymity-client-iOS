//
//  File Name     : Message.swift
//  Project Name  : Anonymity
//  Description   : Message data model
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/6/25 18:17.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import Foundation

struct Message: Identifiable {
    let id: String = UUID().uuidString
    let type: MessageType
    let sender: User
    let content: String
    let timestamp: Date

    // TODO: (Steve X): add receive status & digest check
    var isReceived: Bool = false
    let digest: String
}

extension Message {
    enum MessageType {
        case sent
        case received
    }
}
