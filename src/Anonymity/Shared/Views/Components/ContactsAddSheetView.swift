//
//  File Name     : ContactsAddSheetView.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/7/13 12:32.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import SwiftUI

struct ContactsAddSheetView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var vm: ContactsViewModel

    @State var contact: Contact? = nil
    @State var uid: String = ""
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var showTextInvalidAlert: Bool = false

    var editMode: Bool = false

    var body: some View {
        Form {
            Section(header: Text("Empty Value")
                .foregroundColor(.red)
            ) {
                TextField("Contact UID", text: self.$uid, onEditingChanged: { _ in
                    self.showTextInvalidAlert = false
                })

                TextField("First Name", text: self.$firstName, onEditingChanged: { _ in
                    self.showTextInvalidAlert = false
                })

                TextField("Last Name", text: self.$lastName, onEditingChanged: { _ in
                    self.showTextInvalidAlert = false
                })
            }

            Section {
                Button(action: {
                    if self.firstName.count > 0 {
                        self.showTextInvalidAlert = false

                        self.vm.addContact(uid: uid, firstName: firstName, lastName: lastName)
                        self.presentation.wrappedValue.dismiss()
                    } else {
                        self.showTextInvalidAlert = true
                    }
                }, label: {
                    Text("Save")
                })
                Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                })
            }
        }
        .navigationTitle("Add New Contact")
    }
}

struct ContactsAddSheetView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContactsAddSheetView()
                .environmentObject(ContactsViewModel())
        }
    }
}
