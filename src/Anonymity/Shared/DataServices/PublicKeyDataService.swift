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
    static func publish() { }
}
