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

import Firebase
import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var MsgListVM: MessageListViewModel
    @EnvironmentObject private var ChatVM: ChatViewModel
    @EnvironmentObject private var ContactVM: ContactsViewModel

    @Binding var username: String
    @Binding var password: String
    @Binding var isUserLoggedOut: Bool
    @State var statusMessage = ""

//    @State var createMode: Bool = false

    init(
        username: Binding<String> = .constant(""),
        password: Binding<String> = .constant(""),
        isUserLoggedOut: Binding<Bool> = .constant(true)
    ) {
        _username = username
        _password = password
        _isUserLoggedOut = isUserLoggedOut
    }

    var body: some View {
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

//                SecureField(createMode ? "PASSWORD AGAIN" : "", text: $password)
//                    .frame(width: 200, height: 10, alignment: .center)
//                    .padding()
//                    .background(.black.opacity(createMode ? 0.1 : 0))
//                    .cornerRadius(20)

                Spacer()

                Text(statusMessage)
                    .foregroundColor(.red)

                Button(action: {
                    Task {
                        await loginUser()
                        MsgListVM.autoRefreshChat()
                        ContactVM.autoRefreshContact()
                        ChatVM.autoRefreshChat()
                    }
                }) {
                    HStack {
                        Text("LOGIN")
                            .fontWeight(.bold)
                        Spacer()
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.system(size: 20))
                    }
                }
                .frame(width: 200, height: 10)
                .padding()
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(20)

                Button(action: {
//                    createMode.toggle()
                    Task {
                        await createNewUser()
                    }
                }) {
                    HStack {
                        Text("Create an account")
                            .fontWeight(.bold)
                        Spacer()
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 20))
                    }
                }
                .frame(width: 200, height: 10)
                .padding()
                .background(.red)
                .foregroundColor(.white)
                .cornerRadius(20)

                Spacer()
            }
        }
        .navigationTitle("Login")
    }
}

extension LoginView {
    // TODO: (Steve X): add error message
    private func createNewUser() async {
        _ = await UserAuthManager.userCreate(username: username, password: password)

//        FirebaseManager.shared.auth.createUser(withEmail: username, password: password) { result, err in
//            if let err = err {
//                statusMessage = "Failed to create new user: \(err.localizedDescription)"
//                print(statusMessage)
//                return
//            }
//
//            statusMessage = "User created successfully: \(result?.user.uid ?? "")"
//            print(statusMessage)
//        }
    }

    // TODO: (Steve X): add error message
    private func loginUser() async {
        let res = await UserAuthManager.userLogin(username: username, password: password)
        isUserLoggedOut = !res
        print("static:", res)

//        FirebaseManager.shared.auth.signIn(withEmail: username, password: password) { result, err in
//            if let err = err {
//                statusMessage = "Failed to login user: \(err.localizedDescription)"
//                print(statusMessage)
//                return
//            }
//
//            statusMessage = "User login successfully: \(result?.user.uid ?? "")"
//            showLoginPage = false
//            print(statusMessage)
//        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
