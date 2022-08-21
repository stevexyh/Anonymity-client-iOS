//
//  File Name     : UIApplication.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.5
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/8/21 02:51.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import Foundation
import SwiftUI

extension UIApplication {
    /// This extension is due to "'windows' was deprecated in iOS 15.0: Use UIWindowScene.windows on a relevant window scene instead".
    /// See [Stack Overflow](https://stackoverflow.com/questions/68387187/how-to-use-uiwindowscene-windows-on-ios-15)
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes

            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }

            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })

            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows

            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
}
