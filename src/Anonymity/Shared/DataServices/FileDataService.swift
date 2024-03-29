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

import FirebaseStorage
import Foundation

class FileDataService {
    private static let db = FirebaseManager.shared.storage

    /// Upload file to Firebase Storage
    /// - Parameters:
    ///   - chatID: ID of chat instance
    ///   - dataURL: URL of file to be uploaded
    static func add(in chatID: Chat.ID, for dataURL: URL) {
        let filename = dataURL.lastPathComponent
        let document = db.reference(withPath: "chat files/\(chatID)/\(filename)")

        do {
            let rawData = try Data(contentsOf: dataURL, options: .uncached)
            guard let cipherData = CryptoManager.symEncrypt(for: rawData, in: chatID) else { return }

            document.putData(cipherData, metadata: nil) { metadata, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                if let metadata = metadata {
                    print(metadata.description)
                }

                document.downloadURL { url, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }

                    if let url = url {
                        let filename = url.lastPathComponent
                        let absStr = url.absoluteString
                        let new_message = Message(
                            chatID: chatID,
                            type: .sent,
                            contentType: .file,
                            senderID: UserAuthManager.currentUser?.uid ?? "",
                            content: absStr,
                            timestamp: .now,
                            isReceived: false
                        )

                        MessageDataService.add(
                            in: chatID,
                            for: new_message
                        )

                        print("Successfully uploaded file: [\(filename)] to URL: [\(absStr)]")
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
            return
        }
    }
}
