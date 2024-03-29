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
    @EnvironmentObject private var ChatVM: ChatViewModel
    @EnvironmentObject private var ContactVM: ContactsViewModel
    @Binding var isUserLoggedOut: Bool

    var username: String?

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

                    Button(action: {
                        UserAuthManager.logOut(with: &isUserLoggedOut)
                    }) {
                        HStack {
                            Image(systemName: "minus.circle")
                            Text("Log Out")
                        }.foregroundColor(.red)
                    }

                }.padding()

                chatListView
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
                let contactID = chat.users.first(where: { $0 != myID }) ?? "<null friend UID>"
                let contact = Contact(for: contactID, in: ContactVM) ?? Contact(uid: contactID, firstName: "UID: \(contactID)", lastName: "")
                let chatName = contact.fullName
                let lastMessage = ChatVM.getLatestMessage(in: chat.id)
                let lastMsgFileName = URL(string: lastMessage?.content ?? "")?.lastPathComponent ?? ""
                let displayMessage = lastMessage?.contentType == .file ? "[File] \(lastMsgFileName)" : lastMessage?.content ?? ""

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
                            Text(displayMessage)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        VStack {
                            Text("\(lastMessage?.timestamp.formatted(date: .abbreviated, time: .shortened) ?? "")")
                                .font(.system(size: 10))
                                .foregroundColor(.gray)

                            Spacer()
                        }
                    }
                    NavigationLink(destination: {
                        ChatView(contact: contact, chat: chat)
                            .onAppear {
                                Task {
                                    await vm.encryptChat(with: contactID, for: chat.id)
                                }
                            }
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
            MessageListView(isUserLoggedOut: Binding<Bool>.constant(false))
                .environmentObject(MessageListViewModel())
        }
    }
}
