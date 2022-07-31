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

    /// Refresh contacts from Firebase FireStore automatically at real time
    /// - Parameter vm: ContactsViewModel
    static func fetchRealTime(vm: ContactsViewModel) {
        guard let myID = UserAuthManager.currentUser?.uid else { return }
        db.document(myID)
            .collection("contacts")
            .addSnapshotListener { query, error in
                if let error = error {
                    print(error)
                }

                if let query = query {
                    query.documentChanges.forEach { change in
                        if change.type == .added {
                            // Encode DicKeys into enum type
                            let data = change.document.data() // .mapKeys { DicKeyManager.ContactDicKey(rawValue: $0) }
                            let new_contact = Contact(
                                uid: data["id"] as? String ?? "",
                                firstName: data["firstName"] as? String ?? "",
                                lastName: data["lastName"] as? String ?? ""
                            )

                            vm.contacts.append(new_contact)
                        } else if change.type == .removed {
                            let data = change.document.data() // .mapKeys { DicKeyManager.ContactDicKey(rawValue: $0) }
                            vm.contacts.removeAll { $0.id == data["id"] as? String }
                        }
                    }
                }
            }
    }
}

// protocol FirebaseDB {
////    <#requirements#>
// }
