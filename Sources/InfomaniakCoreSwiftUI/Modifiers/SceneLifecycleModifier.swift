/*
 Infomaniak Core UI - iOS
 Copyright (C) 2024 Infomaniak Network SA

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import InfomaniakCore
import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif
public extension View {
    func sceneLifecycle(willEnterForeground: (() -> Void)? = nil, didEnterBackground: (() -> Void)? = nil) -> some View {
        return modifier(SceneLifecycleModifier(willEnterForeground: willEnterForeground, didEnterBackground: didEnterBackground))
    }
}

struct SceneLifecycleModifier: ViewModifier {
    var willEnterForeground: (() -> Void)?
    var didEnterBackground: (() -> Void)?

    func body(content: Content) -> some View {
        content
            .onAppear {
                /*
                 On iOS/iPadOS, the `UIScene.willEnterForegroundNotification` notification is not posted when
                 the app is opened for the first time.
                 */
                willEnterForeground?()
            }
        #if canImport(UIKit)
            .onReceive(NotificationCenter.default.publisher(for: UIScene.willEnterForegroundNotification)) { _ in
                willEnterForeground?()
            }
            .onReceive(NotificationCenter.default.publisher(for: UIScene.didEnterBackgroundNotification)) { _ in
                didEnterBackground?()
            }
        #elseif canImport(AppKit)
            .onReceive(NotificationCenter.default.publisher(for: NSApplication.didBecomeActiveNotification)) { _ in
                willEnterForeground?()
            }
            .onReceive(NotificationCenter.default.publisher(for: NSApplication.didResignActiveNotification)) { _ in
                didEnterBackground?()
            }
        #endif
    }
}
