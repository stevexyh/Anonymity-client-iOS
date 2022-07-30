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
    @StateObject private var vm = ChatViewModel()

    // TODO: (Steve X): REMOVE BEFORE FLIGHT: change to real Chat.person.name
    let name: String
    @State private var text: String = ""
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
                        EncryptionInfoSubView(name: name)

                        ForEach(vm.chat.messages) { msg in
                            HStack {
                                ZStack {
                                    MessageBubbleSubView(id: msg.id, maxWidth: geometry.size.width * 0.8, type: msg.type, content: "\(msg.id): \(msg.content)")
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
        }
        .toolbar {
            NavigationLink(destination: {
                UserProfileView(tmpName: name)
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
                TextField("Text here...", text: $text)
                    .padding(.horizontal)
                    .frame(height: height)
                    .background(.thickMaterial)
                    .cornerRadius(height)
                    .focused($isFocused)

                Button(action: {
                    vm.sendMessage(
                        // TODO: (Steve X): REMOVE BEFORE FLIGHT: change to dynamic chatID
                        chatId: "0",
                        type: .sent,
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
    let id: String
    let maxWidth: CGFloat?
    let type: Message.MessageType
    let content: String

    var body: some View {
        Text(content)
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background((type == .received) ? .gray.opacity(0.3) : .green.opacity(0.6))
            .cornerRadius(10)
            .frame(maxWidth: maxWidth, alignment: (type == .received) ? .leading : .trailing)
    }
}

struct EncryptionInfoSubView: View {
    let name: String

    var body: some View {
        HStack {
            Image(systemName: "lock.open.fill")
            Text("Chat with \(name) has not been encrypted yet")
        }
        .font(.system(size: 14))
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(.orange.opacity(0.3))
        .foregroundColor(.black.opacity(0.7))
        .cornerRadius(20)
        .padding()
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatView(name: "Alice")
                .environmentObject(MessageListViewModel())
        }
    }
}
