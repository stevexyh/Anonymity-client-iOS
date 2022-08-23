//
//  File Name     : ClipboardSubView.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.5
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/8/23 03:50.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import SwiftUI

struct ClipboardSubView: View {
    private let clipboard = UIPasteboard.general

    @State private var status: ClipBoardStatus = .reset

    var content: String

    var body: some View {
        HStack {
            Text(content)
                .foregroundColor(.gray)

            Divider()

            HStack {
                switch status {
                case .copied:
                    copiedView
                case .reset:
                    resetView
                }
            }
            .font(.system(size: 20))
            .padding(.leading)
        }
        .onTapGesture {
            clipboard.string = content
            status = .copied

            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                status = .reset
            }
        }
    }
}

struct ClipboardSubView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ClipboardSubView(content: "test copy clipboard")
            ClipboardSubView(content: "test copy clipboard")
        }
    }
}

extension ClipboardSubView {
    enum ClipBoardStatus {
        case copied
        case reset
    }

    private var resetView: some View {
        Image(systemName: "doc.on.clipboard")
            .foregroundColor(.accentColor)
    }

    private var copiedView: some View {
        Image(systemName: "checkmark.circle")
            .foregroundColor(.green)
    }
}
