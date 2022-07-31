//
//  File Name     : AnonymityApp.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/6/18 06:01.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import SwiftUI

@main
struct AnonymityApp: App {
    @StateObject private var vm1 = ContactsViewModel()
    @StateObject private var vm2 = MessageListViewModel()
    @StateObject private var vm3 = ChatViewModel()

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomePageView()
                .environmentObject(vm1)
                .environmentObject(vm2)
                .environmentObject(vm3)
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
