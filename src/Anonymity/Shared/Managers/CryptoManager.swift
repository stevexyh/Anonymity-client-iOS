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

    /// Generate asymmetric key pairs (PrivateKey & PublicKey)
    static func keyGen() {
        privateKey = Curve25519.KeyAgreement.PrivateKey()
    }

    // (Steve X) TODO: Save PublicKey Base64 string in Firestore
    /// Publish Base64 string of PublicKey
    /// - Returns: Base64 string of PublicKey
    static func keyPublish() -> String? {
        return publicKey?.rawRepresentation.base64EncodedString()
    }

    /// Derivate shared symmetric secret key from PublicKey of others
    /// - Parameters:
    ///   - pubKeyB64Str: Base64 string of PublicKey of others
    ///   - size: The length in bytes of resulting symmetric key
    static func symKeyDerivation(with pubKeyB64Str: String, size: Int = 256) {}

    /// Symmetrically encrypt a plaintext
    /// - Parameters:
    ///   - plainText: message in plain text
    ///   - chatID: id of chat
    /// - Returns: Base64 string of cipher text
    static func symEncrypt(for plainText: String, in chatID: Chat.ID) {}

    /// Symmetrically decrypt a ciphertext
    /// - Parameters:
    ///   - cipherB64Str: Base64 string of cipher text
    ///   - chatID: id of chat
    /// - Returns: decrypted message in plain text
    static func symDecrypt(from cipherB64Str: String, in chatID: Chat.ID) {}
}
