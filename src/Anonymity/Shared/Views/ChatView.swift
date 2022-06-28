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
    // TODO: (Steve X): REMOVE BEFORE FLIGHT: change to real Chat.person.name
    let name: String

    var body: some View {
        VStack {
            Text("\(name)")

            let columns = [GridItem(.flexible(minimum: 10))]
            GeometryReader { geometry in
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 0) {
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

                        ForEach(0 ..< 10) { id in
                            HStack {
                                ZStack {
                                    MessageBubbleView(id: id, maxWidth: geometry.size.width * 0.8)
                                        .padding()
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: ((id % 2) != 0) ? .leading : .trailing)
                        }
                    }
                }
            }
            .background(.gray.opacity(0.2))
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(name: "Alice")
    }
}

struct MessageBubbleView: View {
    let id: Int
    let maxWidth: CGFloat?

    var body: some View {
        Text("\(id): test sample message test sample message test sample message test sample message ------------------------------------------")
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background(((id % 2) != 0) ? .gray.opacity(0.3) : .green.opacity(0.6))
            .cornerRadius(10)
            .frame(maxWidth: maxWidth, alignment: ((id % 2) != 0) ? .leading : .trailing)
    }
}
