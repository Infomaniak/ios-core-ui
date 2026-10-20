/*
 Infomaniak Core UI - iOS
 Copyright (C) 2026 Infomaniak Network SA

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

import SwiftUI

public extension EnvironmentValues {
    @Entry
    var hasDeviceHinge = false
}

public extension View {
    func detectDeviceHinge(store: UserDefaults = .standard) -> some View {
        modifier(IKDeviceHingeDetectorModifier(store: store))
    }
}

public struct IKDeviceHingeDetectorModifier: ViewModifier {
    @AppStorage private var hasHinge: Bool
    @Environment(\.hasDeviceHinge) private var inheritedHasDeviceHinge

    static let storageKey = "com.infomaniak.coreui.deviceHasHinge"

    public init(store: UserDefaults = .standard) {
        _hasHinge = AppStorage(wrappedValue: false, Self.storageKey, store: store)
    }

    public func body(content: Content) -> some View {
        detectedContent(content)
            .environment(\.hasDeviceHinge, inheritedHasDeviceHinge || hasHinge)
    }

    @ViewBuilder
    private func detectedContent(_ content: Content) -> some View {
        #if !targetEnvironment(macCatalyst) && os(iOS)
        if #available(iOS 27.1, *) {
            content
                .onHingeChange { _, newContext in
                    updateHingeDetection(isHingePresent: newContext.hinge != nil)
                }
        } else {
            content
        }
        #else
        content
        #endif
    }

    func updateHingeDetection(isHingePresent: Bool) {
        guard isHingePresent && !hasHinge else { return }
        hasHinge = true
    }
}
