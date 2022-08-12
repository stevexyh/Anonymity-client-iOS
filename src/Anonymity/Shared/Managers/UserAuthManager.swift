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

import Firebase
import Foundation

class UserAuthManager {
    private static var _loginStatus: Bool = false
    private static var _currentUser: Firebase.User?

    static var loginStatus: Bool {
        _loginStatus
    }

    static var currentUser: Firebase.User? {
        _currentUser
//        FirebaseManager.shared.auth.currentUser
    }

    // MARK: - (Steve X): HIGHLIGHT: async Login -

    /// Login user with Firebase and return the boolean auth result
    ///
    /// Ref: [](https://peterfriese.dev/posts/firebase-async-calls-swift/)
    ///
    /// Async events with `async` & `await` should be used to make sure return value is changed after Firebase signIn completed.
    /// Also, these async events should be executed on main thread.
    ///
    /// Fixed Runtime issue by @MainActor:
    /// ```
    /// -[UIApplication setDelegate:] must be used from main thread only
    /// ```
    ///
    /// It really took me a long time to figure these out...😫
    ///
    /// - Parameters:
    ///   - username: Currently using email
    ///   - password:
    /// - Returns: boolean auth result
    @MainActor
    static func userLogin(username: String, password: String) async -> Bool {
        if let status = try? await FirebaseManager.shared.auth.signIn(withEmail: username, password: password) {
            _loginStatus = true
            _currentUser = status.user

            return true
        }

        return false
    }

    /// Create a new user with Firebase and return the boolean result
    /// - Parameters:
    ///   - username: Currently using email
    ///   - password:
    /// - Returns: boolean user creation result
    @MainActor
    static func userCreate(username: String, password: String) async -> Bool {
        let status = try? await FirebaseManager.shared.auth.createUser(withEmail: username, password: password)
        return status != nil
    }

    /// Log out current user
    /// - Parameter logOutStatus: the log out status to be changed
    static func logOut(with logOutStatus: inout Bool) {
        // Unsubscribe listeners of DataServices
        MessageDataService.unsubscribe()
        ContactDataService.unsubscribe()
        ChatDataService.unsubscribe()
        PublicKeyDataService.unsubscribe()

        if (try? FirebaseManager.shared.auth.signOut()) != nil {
            logOutStatus = true
            _loginStatus = false
            _currentUser = nil
        }
    }
}
