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
    static func publish(completion: @escaping (Bool) -> Void = { _ in }) {
        guard let myID = UserAuthManager.currentUser?.uid else {
            print(">>> Not login!!!")
            return
        }

        let pubKeyB64Str = CryptoManager.pubKeyB64Str
        let document = db.document(myID)

        listener = document.addSnapshotListener { _, error in
            if let error = error {
                print(error)
                completion(false)
            }

            // Encode DicKeys into enum type
            let data: [DicKeyManager.PublicKeyDicKey: Any] = [
                .publicKey: pubKeyB64Str ?? "N/A",
            ]

            // Decode DicKeys into rawValue String
            let decodedData = data.mapKeys { $0.rawValue }

            document.setData(decodedData)
            completion(true)
        }
    }

    /// Remove Firebase Firestore listener
    static func unsubscribe() {
        listener?.remove()
    }

    /// Fetch Base64 string of target user's PublicKey
    /// - Parameter userID: uid of target user
    /// - Returns: Base64 string of target user's PublicKey
    @MainActor
    static func fetchPubKeyB64Str(for userID: User.ID) async -> String? {
        guard let dataDict = try? await
            db
            .document(userID)
            .getDocument()
            .data()
        else {
            print("Fail to fetch PublicKey for UserID: [\(userID)]")
            return nil
        }

        let data = dataDict.mapKeys { DicKeyManager.PublicKeyDicKey(rawValue: $0) }
        let pubKeyB64Str = data[.publicKey] as? String

        return pubKeyB64Str
    }
}
