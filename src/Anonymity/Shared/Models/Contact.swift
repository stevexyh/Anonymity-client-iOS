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
    let firstName: String?
    let lastName: String?

    var fullName: String {
        "\(firstName ?? "") \(lastName ?? "")"
    }
}

extension Contact {
    /// Fetch Contact instance from database in DataService
    /// - Parameter id: Contact ID
    init?(for id: Contact.ID, in vm: ContactsViewModel) {
        guard let contact = vm.contacts.first(where: { $0.id == id }) else { return nil }
        self = contact
    }
}
