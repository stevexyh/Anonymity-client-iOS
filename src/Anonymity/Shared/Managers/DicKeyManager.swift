//
//  File Name     : DicKeyManager.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/7/30 22:24.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import Foundation

protocol DicKey {
    var rawValue: String { get }
}

/// Constants for Firestore Database storage keys
struct DicKeyManager {
    enum ChatDicKey: String, DicKey {
        case id
        case users
        case messages
        case keySaltB64Str
    }

    enum ContactDicKey: String, DicKey {
        case id
        case firstName
        case lastName
        case fullName
    }

    enum MessageDicKey: String, DicKey {
        case id
        case chatID
        case type
        case contentType
        case senderID
        case content
        case timestamp
        case isReceived
        case isEncrypted
        case digest
    }

    enum PublicKeyDicKey: String, DicKey {
        case publicKey
    }
}
