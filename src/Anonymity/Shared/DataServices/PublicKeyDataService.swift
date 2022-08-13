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

import Firebase
import Foundation

class PublicKeyDataService {
    private static let db = FirebaseManager.shared.firestore.collection("users")
    private static var listener: Firebase.ListenerRegistration?

    /// Publish PublicKey to Firebase FireStore automatically at real time
    static func publish() {
        guard let myID = UserAuthManager.currentUser?.uid else { return }

        let pubKeyB64Str = CryptoManager.pubKeyB64Str
        let document = db.document(myID)

        listener = document.addSnapshotListener { _, error in
            if let error = error {
                print(error)
            }

            // Encode DicKeys into enum type
            let data: [DicKeyManager.PublicKeyDicKey: Any] = [
                .publicKey: pubKeyB64Str ?? "N/A",
            ]

            // Decode DicKeys into rawValue String
            let decodedData = data.mapKeys { $0.rawValue }

            document.updateData(decodedData)
        }
    }

    /// Remove Firebase Firestore listener
    static func unsubscribe() {
        listener?.remove()
    }

    // (Steve X) TODO: Fetch Base64 string of target user's PublicKey
    /// Fetch Base64 string of target user's PublicKey
    /// - Parameter userID: uid of target user
    /// - Returns: Base64 string of target user's PublicKey
    static func fetchPubKeyB64Str(for userID: User.ID) -> String? { return nil }
}
