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
    // TODO: (Steve X): REMOVE BEFORE FLIGHT: change to real Chat.person.name
    var tmpName: String? = ""

    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var isMuted: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 0)

                VStack(alignment: .center, spacing: 0) {
                    Image(systemName: "person.circle")
                        .font(.system(size: 80))

                    // TODO: (Steve X): REMOVE BEFORE FLIGHT: Change to dynamic name
                    Text("\(tmpName ?? firstName)")
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
                    Text("ID Hash: \("qwud-hdqb-jwbd-jndq")")
                        .foregroundColor(.gray)

                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
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
            }
            Spacer()
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(tmpName: "Alice")
    }
}
