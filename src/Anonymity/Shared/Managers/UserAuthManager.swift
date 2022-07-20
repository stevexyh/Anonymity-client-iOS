//
//  File Name     : UserAuthManager.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/7/20 14:40.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import Foundation

class UserAuthManager {
//    static var loginStatus: Bool = false
//    static var loginStatusMessage: String?
//    static var createStatus: Bool = false
//    static var createStatusMessage: String?

    // FIXME: (Steve X): Runtime issue: -[UIApplication setDelegate:] must be used from main thread only
    static func userLogin(username: String, password: String) async -> Bool {
        if let _ = try? await FirebaseManager.shared.auth.signIn(withEmail: username, password: password) {
            return true
        }

        return false
    }
}
