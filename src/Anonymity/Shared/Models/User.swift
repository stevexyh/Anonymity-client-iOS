//
//  File Name     : User.swift
//  Project Name  : Anonymity
//  Description   : User data model
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/6/23 23:59.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import Foundation

struct User: Identifiable, Comparable {
    // TODO: (Steve X): change uuid to hash(username)
    var id: String = UUID().uuidString
    let username: String
    let password: String
    let avatarURL: String
    let onlineStatus: OnlineStatus
}

extension User {
    enum OnlineStatus {
        case online
        case offline
        case busy
    }

    static func < (lhs: User, rhs: User) -> Bool {
        return lhs.id < rhs.id
    }

    // (Steve X) FIXME: fetch form DataService.find, avoid VM
    /// Fetch User instance from database in DataService
    /// - Parameter id: User ID
    init?(for id: User.ID) {
        guard let user = UserDataService.sample.first(where: { $0.id == id }) else { return nil }
        self = user
    }
}
