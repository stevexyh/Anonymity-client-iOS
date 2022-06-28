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

    var body: some View {
        Text("Chat with \(name)")
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(name: "Alice")
    }
}
