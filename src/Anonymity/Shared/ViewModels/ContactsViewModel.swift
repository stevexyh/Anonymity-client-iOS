//
//  File Name     : ContactsViewModel.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/7/13 00:13.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import Foundation

class ContactsViewModel: ObservableObject {
    @Published var contacts: [Contact]

    init() {
        contacts = ContactDataService.contacts
    }

    func addContact(uid: String?, firstName: String?, lastName: String?) {
        let new_contact = Contact(uid: uid, firstName: firstName, lastName: lastName)
        contacts.append(new_contact)
    }
}
