//
//  File Name     : UserProfileView.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/7/5 17:50.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject private var vm: ContactsViewModel

    @State private var isMuted: Bool = false
    @State var contact: Contact

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 0)

                VStack(alignment: .center, spacing: 0) {
                    AvatarView(
                        avatarType: .nameCapital,
                        maxSize: 80,
                        firstName: contact.firstName,
                        lastName: contact.lastName
                    )

                    Text(contact.fullName)
                        .font(.system(size: 40))

                    OnlineStatusView(
                        fontColor: .black.opacity(0.5),
                        fontSize: 14
                    )
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                }
            }
            .padding()
            .background(LinearGradient(
                colors: [.green.opacity(0.3), .blue.opacity(0.5)],
                startPoint: .topLeading, endPoint: .bottomTrailing
            ))

            Form {
                Section(header: Text("Personal Information")) {
                    ClipboardSubView(content: contact.uid)

                    HStack {
                        TextField("First Name", text: $contact.firstName)

                        Divider()

                        TextField("Last Name", text: $contact.lastName)
                    }
                }

                Section(header: Text("Actions")) {
                    Toggle("Mute", isOn: $isMuted)
                    Button(action: {}) {
                        HStack {
                            Text("Delete Contact")
                            Spacer()
                            Image(systemName: "person.crop.circle.badge.xmark")
                                .font(.system(size: 24))
                        }
                    }
                }
                .tint(.red)

                Section {
                    VStack {
                        Button(action: {
                            vm.addContact(contact: contact)
                        }) {
                            HStack {
                                Text("Save")
                                    .fontWeight(.bold)
                                Image(systemName: "person.crop.circle.badge.checkmark")
                            }
                            .frame(width: 100, height: 10)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                        }
                        .buttonStyle(.plain)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .listRowBackground(Color.clear)
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let contact = ContactDataService.sample[0]
        UserProfileView(contact: contact)
    }
}
