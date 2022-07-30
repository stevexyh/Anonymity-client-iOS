//
//  File Name     : Dictionary.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/7/30 22:53.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import Foundation

extension Dictionary {
    /// [Steve Custom Extension]: Returns a new dictionary containing the values of this dictionary with the keys transformed by the given closure.
    ///
    /// Complexity: O(n), where n is the length of the dictionary.
    /// - Parameter transform: A closure that transforms a value.
    ///            `transform` accepts each value of the dictionary as its parameter and returns a transformed value of the same or of a different type.
    /// - Returns: A dictionary containing the keys and transformed values of this dictionary.
    func mapKeys<NewKeyT>(_ transform: (Key) throws -> NewKeyT) rethrows -> [NewKeyT: Value] {
        var newDict = [NewKeyT: Value]()
        try forEach { key, value in
            let newKey = try transform(key)
            newDict[newKey] = value
        }
        return newDict
    }
}
