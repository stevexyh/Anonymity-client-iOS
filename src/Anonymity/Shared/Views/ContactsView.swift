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
    var body: some View {
        // Message list
        List {
            ForEach(0 ..< 15) { id in
                ZStack {
                    HStack {
                        Image(systemName: "person.circle")
                            .font(.system(size: 40))

                        VStack(alignment: .leading) {
                            Text("friend \(id)")
                            OnlineStatusView()
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
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
        .navigationTitle("Contacts")
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContactsView()
        }
    }
}
