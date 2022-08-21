//
//  File Name     : MessageBubbleSubView.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.5
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/8/20 18:54.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import SwiftUI

struct MessageBubbleSubView: View {
    @EnvironmentObject private var vm: ChatViewModel

    let message: Message
    let maxWidth: CGFloat?

    var body: some View {
        let _bubbleColor: Color = (message.type == .received) ? .gray.opacity(0.3) :
            (message.isEncrypted ? .green.opacity(0.6) : .orange.opacity(0.6))
        let filename = URL(string: message.content)?.lastPathComponent
        let invalid = (message.contentType == .file && filename == nil)
        let bubbleColor = invalid ? .red.opacity(0.6) : _bubbleColor

        HStack {
            if message.contentType == .file {
                ZStack {
                    let radius: CGFloat = 60

                    Circle()
                        .foregroundColor(.white)
                        .frame(width: radius, height: radius)

                    Image(systemName: invalid ? "xmark" : "arrow.down")
                        .resizable()
                        .frame(width: radius / 2, height: radius / 2)
                        .foregroundColor(bubbleColor)

                    if vm.showProgress == message.id {
                        DownloadProgressView(progress: $vm.progress, diameter: radius)
                    }
                }
                .padding(.top)
                .padding(.bottom)
                .padding(.trailing)
            } else {
                Image(systemName: message.isEncrypted ? "lock.fill" : "lock.open.fill")
            }

            Text(message.contentType == .text ? message.content : filename ?? "EXPIRED FILE")
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
        .background(bubbleColor)
        .cornerRadius(10)
        .frame(
            maxWidth: maxWidth,
            alignment: (message.type == .received) ? .leading : .trailing
        )
    }
}

struct MessageBubbleSubView_Previews: PreviewProvider {
    static var previews: some View {
        let maxWidth: CGFloat = 300
        VStack {
            MessageBubbleSubView(
                message: MessageDataService.sample[0],
                maxWidth: maxWidth
            )

            MessageBubbleSubView(
                message: MessageDataService.sample[1],
                maxWidth: maxWidth
            )

            MessageBubbleSubView(
                message: Message(
                    id: "",
                    chatID: "",
                    type: .sent,
                    contentType: .text,
                    senderID: "",
                    content: "encrypted message",
                    timestamp: .now,
                    isEncrypted: true,
                    isReceived: true
                ),
                maxWidth: maxWidth
            )

            MessageBubbleSubView(
                message: Message(
                    id: "",
                    chatID: "",
                    type: .sent,
                    contentType: .file,
                    senderID: "",
                    content: "encrypted message",
                    timestamp: .now,
                    isEncrypted: true,
                    isReceived: true
                ),
                maxWidth: maxWidth
            )
        }
        .environmentObject(ChatViewModel())
    }
}
