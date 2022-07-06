//
//  File Name     : SettingsView.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/7/5 21:23.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    // TODO: (Steve X): REMOVE BEFORE FLIGHT: change to real Chat.person.name
    var tmpName: String? = ""

    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var isNotificationOn: Bool = true
    @State private var languageSelected: String = "English"

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ZStack {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 0)

                    VStack(alignment: .center, spacing: 0) {
                        AvatarView(
                            avatarType: .nameCapital,
                            maxSize: 80,
                            firstName: tmpName ?? firstName
                        )

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

                    Section(header: Text("Settings")) {
                        HStack {
                            Image(systemName: "bell.badge.circle.fill")
                                .font(.system(size: 26))
                                .foregroundColor(.red)
                            Toggle("Notifications", isOn: $isNotificationOn)
                        }

                        HStack {
                            NavigationLink(destination: {}) {
                                Image(systemName: "circle.hexagongrid.circle")
                                    .font(.system(size: 26))
                                    .foregroundColor(.cyan)
                                Text("Appearance")
                            }
                        }

                        HStack {
                            Picker(
                                selection: $languageSelected,
                                label: HStack {
                                    Image(systemName: "globe")
                                        .font(.system(size: 26))
                                        .foregroundColor(.blue)
                                    Text("Language")
                                }
                            ) {
                                Text("English").tag("English")
                                Text("-").tag("-")
                            }
                        }
                    }

                    Section(header: Text("Application")) {
                        Link("Term of Service", destination: URL(string: "https://www.google.com")!)
                        Link("Privacy Policy", destination: URL(string: "https://www.google.com")!)
                        Link("GitHub", destination: URL(string: "https://www.google.com")!)
                        Link("Learn More", destination: URL(string: "https://www.google.com")!)
                    }

                    Section(header: Text("Danger Zone").foregroundColor(.red)) {
                        Button(action: {}) {
                            HStack {
                                Text("Delete Account")
                                Spacer()
                                Image(systemName: "trash")
                                    .font(.system(size: 20))
                            }
                        }
                    }
                    .tint(.red)
                }
            }
            .navigationBarHidden(true)
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(tmpName: "Steve")
    }
}
