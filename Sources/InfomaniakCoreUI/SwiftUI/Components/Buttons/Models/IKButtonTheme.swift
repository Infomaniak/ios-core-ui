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

@available(iOS 15.0, *)
@frozen public struct IKButtonTheme {
    public let primary: any ShapeStyle
    public let secondary: any ShapeStyle

    public let disabledPrimary: any ShapeStyle
    public let disabledSecondary: any ShapeStyle

    public let error: any ShapeStyle

    public let smallFont: Font
    public let mediumFont: Font
}

// MARK: - Helpers

@available(iOS 15.0, *)
extension IKButtonTheme {
    func primary(disabled: Bool) -> any ShapeStyle {
        return disabled ? disabledPrimary : primary
    }

    func secondary(disabled: Bool) -> any ShapeStyle {
        return disabled ? disabledSecondary : secondary
    }

    func scaledFont(_ controlSize: ControlSize) -> Font {
        if controlSize == .small {
            return smallFont
        } else {
            return mediumFont
        }
    }
}

// MARK: - Default Theme

@available(iOS 15.0, *)
extension IKButtonTheme {
    static let defaultTheme = IKButtonTheme(
        primary: TintShapeStyle.tint,
        secondary: Color.white,
        disabledPrimary: Color.gray,
        disabledSecondary: Color.white,
        error: Color.red,
        smallFont: .callout,
        mediumFont: .body
    )
}
