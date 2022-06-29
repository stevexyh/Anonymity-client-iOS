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
    @State private var text: String = ""
    @FocusState private var isFocused

    var body: some View {
        VStack {
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

                        ForEach(0 ..< 10) { id in
                            HStack {
                                ZStack {
                                    MessageBubbleSubView(id: id, maxWidth: geometry.size.width * 0.8)
                                        .padding()
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: ((id % 2) != 0) ? .leading : .trailing)
                        }
                    }
                }
            }
            .background(.gray.opacity(0.2))

            toolbarView
        }
        .toolbar {
            Button(action: {}) {
                HStack(alignment: .center) {
                    Text("\(name)")
                        .font(.system(size: 30))
                    Image(systemName: "person.circle")
                        .font(.system(size: 30))
                }
                .padding()
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

                Button(action: {}) {
                    Image(systemName: "arrow.up.circle")
                        .resizable()
                        .frame(width: height, height: height)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct MessageBubbleSubView: View {
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
        }
    }
}
