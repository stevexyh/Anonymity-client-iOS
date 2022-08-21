//
//  File Name     : DownloadProgressView.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.5
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/8/21 03:23.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import SwiftUI

struct DownloadProgressView: View {
    @EnvironmentObject private var vm: ChatViewModel

    @Binding var progress: CGFloat
    var diameter: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .fill(.gray.opacity(0.2))

            ProgressShape(progress: progress, radius: diameter / 2)
                .fill(.gray.opacity(0.7))
                .rotationEffect(.init(degrees: -90))
        }
        .frame(width: diameter, height: diameter)
    }
}

struct DownloadProgressView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadProgressView(progress: .constant(0.2), diameter: 200)
    }
}

struct ProgressShape: Shape {
    var progress: CGFloat
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        return Path { path in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            path.move(to: center)

            path.addArc(
                center: center,
                radius: radius,
                startAngle: .zero,
                endAngle: .init(degrees: progress * 360),
                clockwise: true
            )
        }
    }
}
