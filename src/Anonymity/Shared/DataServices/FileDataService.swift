//
//  File Name     : FileDataService.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.5
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/8/20 16:57.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import Foundation

class FileDataService {
    private static let db = FirebaseManager.shared.storage

    /// Upload file to Firebase Storage
    /// - Parameters:
    ///   - chatID: ID of chat instance
    ///   - dataURL: URL of file to be uploaded
    static func add(in chatID: Chat.ID, for dataURL: URL) {
        // pass
    }
}
