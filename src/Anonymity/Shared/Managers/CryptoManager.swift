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
    // (Steve X) MARK: - SENSITIVE PRIVATE ZONE (This part must keep locally)
    private static var secretKeys: [Chat.ID: SecretKey] = [:]
    private static var privateKey: Curve25519.KeyAgreement.PrivateKey?
    private static var publicKey: Curve25519.KeyAgreement.PublicKey? {
        if privateKey == nil {
            keyGen()
        }

        return privateKey?.publicKey
    }

    // (Steve X) MARK: - Key Agreement by Asymmetric Encryption (ECC)

    /// Base64 string of PublicKey.
    /// If the PublicKey does not exist, generate a new PrivateKey & PublicKey pair.
    static var pubKeyB64Str: String? {
        publicKey?.rawRepresentation.base64EncodedString()
    }

    static func saltGen() -> Data {
        Data(CryptoKit.AES.GCM.Nonce())
    }

    /// Generate asymmetric key pairs (PrivateKey & PublicKey)
    static func keyGen() {
        privateKey = Curve25519.KeyAgreement.PrivateKey()
    }

    // (Steve X) TODO: Add Exception handle
    /// Derivate shared symmetric secret key from PublicKey of others
    /// - Parameters:
    ///   - pubKeyB64Str: Base64 string of PublicKey of others
    ///   - chatID: id of chat
    ///   - size: The length in bytes of resulting symmetric key
    ///   - salt: The salt to use for key derivation
    /// - Returns: A boolean indicates success / failure
    static func symKeyDerivation(
        with pubKeyB64Str: String,
        for chatID: Chat.ID,
        size: Int = 32,
        salt: Data
    ) -> Bool {
        guard let pubKeyData = Data(base64Encoded: pubKeyB64Str) else {
            print(">>> Nil pubKeyData for other user")
            return false
        }

        guard let pubKey = try? Curve25519.KeyAgreement.PublicKey(rawRepresentation: pubKeyData) else {
            print(">>> Nil pubKey for other user")
            return false
        }

        guard self.pubKeyB64Str != nil else {
            print(">>> Nil pubKey for myself")
            return false
        }

        guard let privateKey = privateKey else {
            print(">>> Nil PrivateKey")
            return false
        }

        guard let sharedSecret = try? privateKey.sharedSecretFromKeyAgreement(with: pubKey) else {
            print(">>> Nil sharedSecret")
            return false
        }

        let key = sharedSecret.hkdfDerivedSymmetricKey(
            using: SHA256.self,
            salt: salt,
            sharedInfo: Data(),
            outputByteCount: size
        )

        secretKeys[chatID] = SecretKey(key: key, salt: salt)

        return true
    }

    // (Steve X) MARK: - Symmetric Encryption & Decryption (AES)
    /// Symmetrically encrypt a plaintext
    /// - Parameters:
    ///   - plainText: message in plain text
    ///   - chatID: id of chat
    /// - Returns: Base64 string of combined SealBox Data(nonce, ciphertext, tag)
    static func symEncrypt(for plainText: String, in chatID: Chat.ID) -> String? {
        guard let secKey = secretKeys[chatID] else {
            print(">>> Nil SecKey")
            return nil
        }

        guard let plainTextData = plainText.data(using: .utf8) else {
            print(">>> Nil Plain Text Data")
            return nil
        }

        let sealedBox = try? AES.GCM.seal(plainTextData, using: secKey.key)
        let combinedB64Str = sealedBox?.combined?.base64EncodedString()

        return combinedB64Str
    }

    /// Symmetrically decrypt a ciphertext
    /// - Parameters:
    ///   - combinedB64Str: Base64 string of cipher text
    ///   - chatID: id of chat
    /// - Returns: decrypted message in plain text
    static func symDecrypt(from combinedB64Str: String, in chatID: Chat.ID) -> String? {
        guard let secKey = secretKeys[chatID] else {
            print(">>> Nil SecKey")
            return nil
        }

        guard let combinedData = Data(base64Encoded: combinedB64Str) else {
            print(">>> Nil CombinedData")
            return nil
        }

        guard let sealedBox = try? AES.GCM.SealedBox(combined: combinedData) else {
            print(">>> Nil SealedBox")
            return nil
        }

        guard let decryptedData = try? AES.GCM.open(sealedBox, using: secKey.key) else {
            print(">>> Nil Decrypted Data")
            return nil
        }

        let decryptedText = String(data: decryptedData, encoding: .utf8)

        return decryptedText
    }
}

// (Steve X) MARK: - Extensions
extension CryptoManager {
    struct SecretKey {
        let key: SymmetricKey
        let salt: Data
    }
}
