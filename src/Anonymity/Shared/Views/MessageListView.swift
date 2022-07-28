//
//  File Name     : MessageListView.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/6/27 23:25.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import SwiftUI

struct MessageListView: View {
    @EnvironmentObject private var vm: MessageListViewModel

    var username: String?
    @Binding var showLoginPage: Bool

    var body: some View {
        ZStack {
            VStack {
                LinearGradient(
                    colors: [.green.opacity(0.3), .blue.opacity(0.5)],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
                .frame(height: 150, alignment: .top)
                .ignoresSafeArea()
                Spacer()
            }

            VStack {
                // Status bar
                HStack {
                    AvatarView(
                        avatarType: .nameCapital,
                        maxSize: 60,
                        firstName: username
                    )

                    VStack(alignment: .leading, spacing: 4) {
                        Text(username ?? "(null)")
                            .font(.title)

                        OnlineStatusView()
                    }

                    Spacer()

                    Image(systemName: "plus.circle")

                }.padding()

                if username != nil {
                    chatListView
                } else {
                    Spacer()

                    Button(action: {
                        showLoginPage = true
                    }) {
                        HStack {
                            Text("Please log in first")
                            Image(systemName: "arrow.right.circle.fill")
                                .font(.system(size: 20))
                        }
                    }
                    .frame(height: 10)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(20)

                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

extension MessageListView {
    // Message list
    private var chatListView: some View {
        List {
            ForEach(vm.chats) { chat in
                let myID = UserAuthManager.currentUser?.uid ?? "<null myID>"
                let contact = chat.users.first(where: { $0 != myID }) ?? "<null>"
                let chatName = Contact(for: contact)?.fullName ?? "<null firendID: \(chat.users)\n myID: \(myID)>"

                ZStack {
                    HStack {
                        AvatarView(
                            avatarType: .nameCapital,
                            maxSize: 40,
                            firstName: chatName,
                            lastName: ""
                        )

                        VStack(alignment: .leading) {
                            Text(chatName)
                            Text("This is a piece of message...")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        VStack {
                            Text("\(Date().formatted(date: .omitted, time: .shortened))")
                                .font(.system(size: 10))
                                .foregroundColor(.gray)

                            Spacer()
                        }
                    }
                    NavigationLink(destination: {
                        ChatView(name: chatName)
                    }) {
                        EmptyView()
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

struct MessageListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MessageListView(username: "<DEBUG>", showLoginPage: Binding.constant(false))
                .environmentObject(MessageListViewModel())
        }
    }
}
