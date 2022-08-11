//
//  File Name     : CryptoManager.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/8/11 17:51.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import CryptoKit
import Foundation

class CryptoManager {
    private static var secretKeys: [Chat.ID: SymmetricKey] = [:]
    private static var privateKey: Curve25519.KeyAgreement.PrivateKey?
    private static var publicKey: Curve25519.KeyAgreement.PublicKey? {
        privateKey?.publicKey
    }

    static func keyGen() {}
    static func keyPublish() {}
    static func symKeyDerivation(with pubKeyB64Str: String, size: Int = 256) {}
    static func symEncrypt(for plainText: String, in chatID: Chat.ID) {}
    static func symDecrypt(from cipherB64Str: String, in chatID: Chat.ID) {}
}
