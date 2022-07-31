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
    @EnvironmentObject private var vm: ContactsViewModel
    @EnvironmentObject private var MessageListVM: MessageListViewModel

    var username: String? = ""
    @Binding var showLoginPage: Bool
    @State var showAddSheet: Bool = false

    var body: some View {
        VStack {
            if username != nil {
                contactsListView
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
        .toolbar {
            Button(action: {
                showAddSheet = true
            }) {
                Image(systemName: "plus")
            }
            .sheet(isPresented: $showAddSheet) {
                NavigationView {
                    ContactsAddSheetView()
                }
            }
        }
    }
}

extension ContactsView {
    var contactsListView: some View {
        List {
            ForEach(vm.contacts) { contact in
                ZStack {
                    HStack {
                        AvatarView(
                            avatarType: .nameCapital,
                            maxSize: 50,
                            firstName: "\(contact.firstName ?? "")",
                            lastName: "\(contact.lastName ?? "")"
                        )

                        VStack(alignment: .leading) {
                            Text(contact.fullName)

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
                        // TODO: (Steve X): REMOVE BEFORE FLIGHT: set chatID
                        ChatView(name: contact.fullName, chatID: "")
                            .onAppear {
                                guard let myID = UserAuthManager.currentUser?.uid else { return }
                                let withID = contact.id
                                MessageListVM.addChat(by: myID, with: [withID])
                            }
                    }) {
                        EmptyView()
                    }
                }
            }
        }
        .listStyle(.sidebar)
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContactsView(showLoginPage: Binding.constant(false))
                .environmentObject(ContactsViewModel())
        }
    }
}
