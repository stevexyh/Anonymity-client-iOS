//
//  File Name     : UserDataService.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/7/11 17:23.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import Foundation

class UserDataService {
    static let users: [User] = [
        User(username: "a1", password: "aaa", avatarURL: "test", onlineStatus: .online),
        User(username: "a2", password: "aaa", avatarURL: "test", onlineStatus: .busy),
        User(username: "a3", password: "aaa", avatarURL: "test", onlineStatus: .online),
        User(username: "b1", password: "aaa", avatarURL: "test", onlineStatus: .offline),
        User(username: "b2", password: "aaa", avatarURL: "test", onlineStatus: .busy),
    ]
}
