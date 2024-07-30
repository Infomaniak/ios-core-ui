/*
 Infomaniak Core UI - iOS
 Copyright (C) 2023 Infomaniak Network SA

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

// MARK: - EnvironmentValues

@available(iOS 15.0, *)
public extension EnvironmentValues {
    // MARK: IKButtonPrimaryStyleKey

    var ikButtonPrimaryStyle: any ShapeStyle {
        get {
            self[IKButtonPrimaryStyleKey.self]
        }
        set {
            self[IKButtonPrimaryStyleKey.self] = newValue
        }
    }

    private struct IKButtonPrimaryStyleKey: EnvironmentKey {
        static let defaultValue: any ShapeStyle = TintShapeStyle.tint
    }

    // MARK: IKButtonSecondaryStyleKey

    var ikButtonSecondaryStyle: any ShapeStyle {
        get {
            self[IKButtonSecondaryStyleKey.self]
        }
        set {
            self[IKButtonSecondaryStyleKey.self] = newValue
        }
    }

    private struct IKButtonSecondaryStyleKey: EnvironmentKey {
        static let defaultValue: any ShapeStyle = Color.primary
    }

    // MARK: IKButtonThemeKey

    var ikButtonTheme: IKButtonTheme {
        get {
            self[IKButtonThemeKey.self]
        }
        set {
            self[IKButtonThemeKey.self] = newValue
        }
    }

    private struct IKButtonThemeKey: EnvironmentKey {
        static let defaultValue = IKButtonTheme.defaultTheme
    }

    // MARK: IKButtonFullWidthKey

    var ikButtonFullWidth: Bool {
        get {
            self[IKButtonFullWidthKey.self]
        }
        set {
            self[IKButtonFullWidthKey.self] = newValue
        }
    }

    private struct IKButtonFullWidthKey: EnvironmentKey {
        static let defaultValue = false
    }

    // MARK: IKButtonLoadingKey

    var ikButtonLoading: Bool {
        get {
            self[IKButtonLoadingKey.self]
        }
        set {
            self[IKButtonLoadingKey.self] = newValue
        }
    }

    private struct IKButtonLoadingKey: EnvironmentKey {
        static let defaultValue = false
    }
}

// MARK: - View extension

@available(iOS 15.0, *)
public extension View {
    func ikButtonTheme(_ theme: IKButtonTheme) -> some View {
        environment(\.ikButtonTheme, theme)
    }

    func ikButtonFullWidth(_ fullWidth: Bool) -> some View {
        environment(\.ikButtonFullWidth, fullWidth)
    }

    func ikButtonLoading(_ loading: Bool) -> some View {
        environment(\.ikButtonLoading, loading)
    }
}
