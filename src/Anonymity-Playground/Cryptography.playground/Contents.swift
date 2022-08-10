import CryptoKit
import UIKit

// (Steve X) MARK: - AES Symmetric Encryption
// (Steve X) MARK: Encryption
let plainText = "Hello, playground".data(using: .utf8) ?? Data()
let digest = SHA256.hash(data: plainText)
let secretKey = SymmetricKey(size: .bits256)
let sealedBox = try? AES.GCM.seal(plainText, using: secretKey)
let cipherData = sealedBox?.ciphertext

// (Steve X) MARK: for transmission
let nonce = sealedBox?.nonce
let tag = sealedBox?.tag
let cipherBase64Str = cipherData?.base64EncodedString()

// (Steve X) MARK: Decryption
let decodedCipher = Data(base64Encoded: cipherBase64Str ?? "")
let decodedSealBox = try! AES.GCM.SealedBox(
    nonce: nonce.unsafelyUnwrapped,
    ciphertext: decodedCipher.unsafelyUnwrapped,
    tag: tag.unsafelyUnwrapped
)

let decryptedData = try? AES.GCM.open(decodedSealBox, using: secretKey)
let decryptedText = String(data: decryptedData ?? Data(), encoding: .utf8)
