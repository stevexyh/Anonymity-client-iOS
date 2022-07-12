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
            ForEach(0 ..< 15) { id in
                ZStack {
                    HStack {
                        AvatarView(
                            avatarType: .nameCapital,
                            maxSize: 40,
                            firstName: "friend",
                            lastName: "\(id)"
                        )

                        VStack(alignment: .leading) {
                            Text("friend \(id)")
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
                        ChatView(name: "friend \(id)")
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
            MessageListView(showLoginPage: Binding.constant(false))
        }
    }
}
