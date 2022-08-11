//
//  File Name     : PublicKeyDataService.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/8/11 22:00.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import Foundation

class PublicKeyDataService {
    static let db = FirebaseManager.shared.firestore.collection("users")

    /// Publish PublicKey to Firebase FireStore automatically at real time
    static func publish() {
        guard let myID = UserAuthManager.currentUser?.uid else { return }
        let pubKeyB64Str = CryptoManager.keyPublish()
        let document = db.document(myID)

        document.addSnapshotListener { _, error in
            if let error = error {
                print(error)
            }

            // (Steve X) TODO: DicKeyManager.PubKeyDicKey
            let data: [String: Any] = [
                "publicKey": pubKeyB64Str ?? "null",
            ]

            // Decode DicKeys into rawValue String
            let decodedData = data // .mapKeys { $0.rawValue }

            document.updateData(decodedData)
        }
    }
}
