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
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    // Status bar
                    HStack {
                        Image(systemName: "circle")
                            .font(.system(size: 50))

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Steve")
                                .font(.title)
                            HStack {
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(.green)

                                Text("online")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                        }

                        Spacer()

                        Image(systemName: "plus.circle")

                    }.padding()

                    // Message list
                    List {
                        ForEach(0 ..< 15) { id in
                            HStack {
                                Image(systemName: "person.circle")
                                    .font(.system(size: 40))

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
                        }
                    }
                    .listStyle(.plain)
                }
                .navigationBarHidden(true)
            }
            .tabItem {
                Label("Chats", systemImage: "quote.bubble")
            }

            // Contacts View
            HStack {
                Text("Contacts Page")
            }
            .tabItem {
                Label("Contacts", systemImage: "person.text.rectangle")
            }

            // Contacts View
            HStack {
                Text("Settings Page")
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
    }
}

struct MessageListView_Previews: PreviewProvider {
    static var previews: some View {
        MessageListView()
    }
}
