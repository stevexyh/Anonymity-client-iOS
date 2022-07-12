//
//  File Name     : LoginView.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/7/12 16:57.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var authSuccess: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(Color.clear)
                    .background(LinearGradient(
                        colors: [.green.opacity(0.3), .blue.opacity(0.5)],
                        startPoint: .topLeading, endPoint: .bottomTrailing
                    ))

                VStack {
                    Spacer()

                    AvatarView(
                        avatarType: .nameCapital,
                        maxSize: 100,
                        firstName: username
                    )
                    .padding()

                    TextField("USERNAME", text: $username)
                        .frame(width: 200, height: 10, alignment: .center)
                        .padding()
                        .background(.black.opacity(0.1))
                        .cornerRadius(20)

                    SecureField("PASSWORD", text: $password)
                        .frame(width: 200, height: 10, alignment: .center)
                        .padding()
                        .background(.black.opacity(0.1))
                        .cornerRadius(20)

                    Spacer()

                    Button(action: {
                        authSuccess = true
                    }) {
                        HStack {
                            Text("LOGIN")
                            Image(systemName: "arrow.right.circle.fill")
                                .font(.system(size: 20))
                        }
                    }
                    .frame(height: 10)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(20)

                    NavigationLink(destination: Text("Logged in as \(username)"), isActive: $authSuccess) {
                        EmptyView()
                    }

                    Spacer()
                }
            }
            .navigationTitle("Login")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
