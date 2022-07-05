//
//  File Name     : OnlineStatusView.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/7/5 17:01.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import SwiftUI

struct OnlineStatusView: View {
    var fontColor: Color? = nil
    var fontSize: CGFloat = 12

    var body: some View {
        HStack {
            Circle()
                .frame(width: fontSize - 4, height: fontSize - 4)
                .foregroundColor(.green)

            Text("online")
                .font(.system(size: fontSize))
                .foregroundColor(fontColor)
        }
    }
}

struct OnlineStatusView_Previews: PreviewProvider {
    static var previews: some View {
        OnlineStatusView(fontSize: 20)
            .previewLayout(.fixed(width: 100, height: 100))
    }
}
