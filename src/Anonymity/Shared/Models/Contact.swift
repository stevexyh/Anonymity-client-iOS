//
//  File Name     : Contact.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/7/13 01:56.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import Foundation

struct Contact: Identifiable {
    var id: String { uid }
    let uid: String
    var firstName: String = ""
    var lastName: String = ""

    var fullName: String {
        "\(firstName) \(lastName)"
    }
}

extension Contact {
    // (Steve X) FIXME: fetch form DataService.find, avoid VM
    /// Fetch Contact instance from database in ContactVM
    /// - Parameter id: Contact ID
    init?(for id: Contact.ID, in vm: ContactsViewModel) {
        guard let contact = vm.contacts.first(where: { $0.id == id }) else { return nil }
        self = contact
    }
}
