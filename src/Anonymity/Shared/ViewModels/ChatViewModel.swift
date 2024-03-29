//
//  File Name     : ChatViewModel.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/7/25 20:55.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import Foundation
import SwiftUI

class ChatViewModel: NSObject, ObservableObject, UIDocumentInteractionControllerDelegate {
    @Published var messages: [Chat.ID: [Message]]
    @Published var showProgress: Message.ID? = nil
    @Published var progress: CGFloat = 0

    override init() {
        messages = [:]
    }

    func sendMessage(
        chatId: Chat.ID,
        type: Message.ReceiveType,
        senderID: String = UserAuthManager.currentUser?.uid ?? "",
        contentType: Message.ContentType,
        content: String,
        timestamp: Date = .now,
        isReceived: Bool = false
    ) {
        let new_message = Message(
            chatID: chatId,
            type: type,
            contentType: contentType,
            senderID: senderID,
            content: content,
            timestamp: timestamp,
            isReceived: isReceived
        )

        MessageDataService.add(in: chatId, for: new_message)
    }

    func autoRefreshChat() {
        messages.removeAll()
        MessageDataService.fetchRealTime(vm: self)
    }

    func getLatestMessage(in chatID: Chat.ID) -> Message? {
        return messages[chatID]?.last
    }

    /// Download file of url to a tmp directory, then open a View Controller for preview
    /// - Parameter urlString: url string of target file
    /// - Parameter messageID: ID of message including this file
    func download(from message: Message) {
        let urlString: String = message.content
        let messageID: Message.ID = message.id
        let chatID: Chat.ID = message.chatID

        guard let filename = URL(string: urlString)?.lastPathComponent else { return }

        // Create a reference from an HTTPS URL
        let httpsReference = FirebaseManager.shared.storage.reference(forURL: urlString)

        // Create temporary URL for downloading
        let localTmpURL = FileManager.default.temporaryDirectory.appendingPathComponent(filename)

        showProgress = messageID

        // Download file to the tmp URL
        let downloadTask = httpsReference.write(toFile: localTmpURL) { url, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            if let url = url {
                guard let cipherData = try? Data(contentsOf: url) else { return }
                guard let decryptedData = CryptoManager.symDecrypt(from: cipherData, in: chatID) else { return }
                try? decryptedData.write(to: url, options: .atomic)

                let controller = UIDocumentInteractionController(url: url)
                controller.delegate = self
                controller.presentPreview(animated: true)
            }

            self.showProgress = nil
        }

        // Updating download progress
        downloadTask.observe(.progress) { snapshot in
            let progress = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
            self.progress = progress
            print(progress)
        }
    }

    /// Inherited from UIKit.UIDocumentInteractionControllerDelegate.documentInteractionControllerViewControllerForPreview(_:).
    /// - Parameter controller:
    /// - Returns: UIViewController
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return (UIApplication.shared.keyWindow?.rootViewController)!
    }
}
