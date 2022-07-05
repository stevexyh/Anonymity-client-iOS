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
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var isMuted = false

    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 0) {
                Image(systemName: "person.circle")
                    .font(.system(size: 80))

                // TODO: (Steve X): REMOVE BEFORE FLIGHT: Change to dynamic name
                Text("friend \(1)")
                    .font(.system(size: 40))

                OnlineStatusView()
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }

            Form {
                Section(header: Text("Personal Information")) {
                    Text("ID Hash: \("qwud-hdqb-jwbd-jndq")")
                        .foregroundColor(.gray)

                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                }

                Section(header: Text("Actions")) {
                    Toggle("Mute", isOn: $isMuted)
                    Button(action: {}) {
                        HStack {
                            Text("Delete User")
                            Spacer()
                            Image(systemName: "trash")
                        }
                    }
                }
                .tint(.red)
            }
            Spacer()
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
