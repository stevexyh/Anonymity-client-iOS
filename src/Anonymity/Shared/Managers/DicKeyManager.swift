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
    enum MessageDicKey: String, DicKey {
        case id
        case users
        case messages
    }

    /// Decode DicKey to String (DicKey.rawValue)
    /// - Parameter data: source dictionary
    /// - Returns: [String: Any]
    static func decodeKey<Key: DicKey>(for data: [Key: Any]) -> [String: Any] {
        var rawDic: [String: Any] = [:]

        for (K, V) in data {
            rawDic[K.rawValue] = V
        }

        return rawDic
    }
}
