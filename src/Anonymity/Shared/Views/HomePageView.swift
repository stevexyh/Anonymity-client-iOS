//
//  File Name     : HomePageView.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/7/5 17:30.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import SwiftUI

struct HomePageView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var isUserLoggedOut: Bool = true

    var body: some View {
        TabView {
            NavigationView {
                MessageListView(
                    username: username != "" ? username : nil
                )
            }
            .tabItem {
                Label("Chats", systemImage: "quote.bubble")
            }

            // Contacts Page View
            NavigationView {
                ContactsView()
            }
            .tabItem {
                Label("Contacts", systemImage: "person.text.rectangle")
            }

            // Settings Page View
            NavigationView {
                SettingsView(username: username != "" ? username : nil)
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
        .fullScreenCover(isPresented: $isUserLoggedOut) {
            LoginView(username: $username, password: $password, isUserLoggedOut: $isUserLoggedOut)
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
