//
//  File Name     : AvatarView.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/7/6 01:14.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import SwiftUI

struct AvatarView: View {
    var avatarType: AvatarType? = nil
    var maxSize: CGFloat = 200
    var imgURL: URL? = nil

    var firstName: String? = nil
    var lastName: String? = nil
    var nameCapital: String {
        let fn = String((firstName ?? "").first ?? Character("\0"))
        let ln = String((lastName ?? "").first ?? Character("\0"))
        return String("\(fn)\(ln)").uppercased()
    }

    enum AvatarType {
        case defaultIcon
        case nameCapital
        case image
    }

    var body: some View {
        switch avatarType {
        case .nameCapital:
            nameCapitalAvatar

        case .image:
            Image(systemName: "person.circle")
                .font(.system(size: maxSize))

        default:
            Image(systemName: "person.circle")
                .font(.system(size: maxSize))
        }
    }
}

extension AvatarView {
    private var nameCapitalAvatar: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(
                    colors: [.green.opacity(0.9), .blue.opacity(0.9), .red],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                ))

            Circle()
                .stroke(lineWidth: maxSize / 20)
                .foregroundColor(.white.opacity(0.5))

            Text(nameCapital)
                .font(.system(size: maxSize * 0.5))
                .foregroundColor(.white)
        }.frame(maxWidth: maxSize, maxHeight: maxSize)
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AvatarView()
            AvatarView(avatarType: .nameCapital, firstName: "Alice")
            AvatarView(avatarType: .image)
        }
        .font(.system(size: 200))
        .previewLayout(.sizeThatFits)
    }
}
