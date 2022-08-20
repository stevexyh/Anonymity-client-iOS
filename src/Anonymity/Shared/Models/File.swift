//
//  File Name     : File.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.5
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/8/20 22:12.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

/// File model for exporting files
struct File: FileDocument {
    private var _url: URL?

    var urlString: String?
    var url: URL? {
        _url
    }

    static var readableContentTypes: [UTType] = [.data]

    init(urlString: String) {
        self.urlString = urlString
        _url = URL(string: urlString)
    }

    /// Do not need this func in protocol, set url to nil
    /// - Parameter configuration: configuration description
    init(configuration: ReadConfiguration) throws {
        urlString = nil
        _url = nil
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        if let url = url {
            let file = try FileWrapper(url: url, options: .immediate)
            return file
        }

        return FileWrapper()
    }
}
