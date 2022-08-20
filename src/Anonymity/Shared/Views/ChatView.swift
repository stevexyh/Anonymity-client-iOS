//
//  File Name     : ChatView.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/6/28 01:35.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject private var vm: ChatViewModel

    let name: String
    let chat: Chat
    @State private var text: String = ""
    @State private var chooseFile: Bool = false
    @FocusState private var isFocused

    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.clear)
                .frame(height: 0)
                .background(LinearGradient(
                    colors: [.green.opacity(0.3), .blue.opacity(0.5)],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                ))

            // TODO: (Steve X): add online status here

            let columns = [GridItem(.flexible(minimum: 10))]
            GeometryReader { geometry in
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 0) {
                        EncryptionInfoSubView(name: name, isEncrypted: chat.isEncrypted)

                        ForEach(vm.messages[chat.id] ?? []) { msg in
                            HStack {
                                ZStack {
                                    MessageBubbleSubView(
                                        message: msg,
                                        maxWidth: geometry.size.width * 0.8
                                    )
                                    .padding()
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: (msg.type == .received) ? .leading : .trailing)
                        }
                    }
                }
            }
            .background(.gray.opacity(0.2))

            toolbarView
                .fileImporter(isPresented: $chooseFile, allowedContentTypes: [.data]) { result in
                    do {
                        let fileURL = try result.get()
                        print(fileURL)

                        // (Steve X): REMOVE BEFORE FLIGHT TODO: move DS call to VM
                        FileDataService.add(in: chat.id, for: fileURL)

                    } catch {
                        print(error.localizedDescription)
                    }
                }
        }
        .toolbar {
            NavigationLink(destination: {
                UserProfileView(username: name)
            }) {
                HStack(alignment: .bottom, spacing: 80) {
                    Text("\(name)")
                        .font(.system(size: 30))
                    Image(systemName: "person.circle")
                        .font(.system(size: 30))
                }
                .padding()
                .foregroundColor(.black)
            }
        }
    }
}

extension ChatView {
    private var toolbarView: some View {
        VStack {
            let height: CGFloat = 37

            HStack {
                Button {
                    chooseFile.toggle()
                } label: {
                    Image(systemName: "folder")
                        .resizable()
                        .frame(width: height, height: height * 0.8)
                }

                TextField("Text here...", text: $text)
                    .padding(.horizontal)
                    .frame(height: height)
                    .background(.thickMaterial)
                    .cornerRadius(height)
                    .focused($isFocused)

                Button(action: {
                    vm.sendMessage(
                        chatId: chat.id,
                        type: .sent,
                        contentType: .text,
                        content: self.text
                    )

                    self.text.removeAll()
                }) {
                    Image(systemName: "arrow.up.circle")
                        .resizable()
                        .frame(width: height, height: height)
                }
            }
        }
        .padding()
    }
}

struct MessageBubbleSubView: View {
    let message: Message
    let maxWidth: CGFloat?

    var body: some View {
        HStack {
            Image(systemName: message.isEncrypted ? "lock.fill" : "lock.open.fill")
            Text(message.content)
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
        .background((message.type == .received) ? .gray.opacity(0.3) :
            (message.isEncrypted ? .green.opacity(0.6) : .orange.opacity(0.6)))
        .cornerRadius(10)
        .frame(maxWidth: maxWidth, alignment: (message.type == .received) ? .leading : .trailing)
    }
}

struct EncryptionInfoSubView: View {
    let name: String
    let isEncrypted: Bool

    var body: some View {
        HStack {
            Image(systemName: isEncrypted ? "lock.fill" : "lock.open.fill")
            Text("Chat with \(name) has \(isEncrypted ? "been encrypted" : "not been encrypted yet")")
        }
        .font(.system(size: 14))
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(isEncrypted ? .green.opacity(0.6) : .orange.opacity(0.3))
        .foregroundColor(.black.opacity(0.7))
        .cornerRadius(20)
        .padding()
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatView(name: "Alice", chat: Chat(users: ["11-aa"], messages: []))
                .environmentObject(ChatViewModel())
        }
    }
}
