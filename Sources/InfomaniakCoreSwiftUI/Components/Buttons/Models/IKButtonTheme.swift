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

import DesignSystem
import SwiftUI

@available(iOS 15.0, *)
@frozen public struct IKButtonTheme {
    public let primary: any ShapeStyle
    public let secondary: any ShapeStyle
    public let tertiary: any ShapeStyle

    public let disabledPrimary: any ShapeStyle
    public let disabledSecondary: any ShapeStyle

    public let error: any ShapeStyle

    public let smallFont: Font
    public let mediumFont: Font

    public let cornerRadius: CGFloat

    public init(
        primary: any ShapeStyle,
        secondary: any ShapeStyle,
        tertiary: any ShapeStyle,
        disabledPrimary: any ShapeStyle,
        disabledSecondary: any ShapeStyle,
        error: any ShapeStyle,
        smallFont: Font,
        mediumFont: Font,
        cornerRadius: CGFloat = IKRadius.large
    ) {
        self.primary = primary
        self.secondary = secondary
        self.tertiary = tertiary
        self.disabledPrimary = disabledPrimary
        self.disabledSecondary = disabledSecondary
        self.error = error
        self.smallFont = smallFont
        self.mediumFont = mediumFont
        self.cornerRadius = cornerRadius
    }
}

// MARK: - Helpers

@available(iOS 15.0, *)
extension IKButtonTheme {
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
        tertiary: Color.gray.opacity(0.4),
        disabledPrimary: Color.gray,
        disabledSecondary: Color.white,
        error: Color.red,
        smallFont: .callout,
        mediumFont: .body
    )
}
