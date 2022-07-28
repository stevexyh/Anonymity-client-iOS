//
//  File Name     : ContactDataService.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/7/13 02:13.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import Foundation

class ContactDataService {
    static let db = FirebaseManager.shared.firestore.collection("users")

    static let contacts: [Contact] = [
        Contact(uid: "11-aa", firstName: "Alice", lastName: "Test"),
        Contact(uid: "12-ab", firstName: "Bob", lastName: "Test"),
        Contact(uid: "21-ba", firstName: "Charlie", lastName: "Test"),
    ]

    static func add(userID: User.ID, contact: Contact) {
        let document = db.document(userID).collection("contacts").document(contact.id)
        let data: [String: Any] = [
            "id": contact.id,
            "firstName": contact.firstName ?? "",
            "lastName": contact.lastName ?? "",
            "fullName": contact.fullName,
        ]

        document.setData(data) { error in
            if let error = error {
                print(error)
            }
        }
    }
}

// protocol FirebaseDB {
////    <#requirements#>
// }
