//
//  File Name     : ContactsView.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/7/5 16:52.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import SwiftUI

struct ContactsView: View {
    var username: String? = ""
    @Binding var showLoginPage: Bool

    var body: some View {
        VStack {
            if username != nil {
                List {
                    ForEach(0 ..< 15) { id in
                        ZStack {
                            HStack {
                                AvatarView(
                                    avatarType: .nameCapital,
                                    maxSize: 50,
                                    firstName: "friend",
                                    lastName: "\(id)"
                                )

                                VStack(alignment: .leading) {
                                    Text("friend \(id)")

                                    OnlineStatusView(
                                        fontColor: .black.opacity(0.5),
                                        fontSize: 14
                                    )
                                    .padding(.horizontal, 7)
                                    .padding(.vertical, 2)
                                    .background(.thinMaterial)
                                    .cornerRadius(20)
                                }

                                Spacer()
                            }
                            NavigationLink(destination: {
                                ChatView(name: "friend \(id)")
                            }) {
                                EmptyView()
                            }
                        }
                    }
                }
                .listStyle(.sidebar)
            } else {
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
            }
        }
        .navigationTitle("Contacts")
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContactsView(showLoginPage: Binding.constant(false))
        }
    }
}
