/*
 Infomaniak Core UI - iOS
 Copyright (C) 2025 Infomaniak Network SA

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

#if canImport(UIKit)
import UIKit

public extension UIColor {
    static let avatarColors = [
        UIColor.InfomaniakColors.yellow,
        UIColor.InfomaniakColors.coral,
        UIColor.InfomaniakColors.grass,
        UIColor.InfomaniakColors.fougere,
        UIColor.InfomaniakColors.cobalt,
        UIColor.InfomaniakColors.jean,
        UIColor.InfomaniakColors.tropical,
        UIColor.InfomaniakColors.mauve,
        UIColor.InfomaniakColors.prince
    ]

    class func backgroundColor(from hash: Int, with colors: [UIColor] = UIColor.avatarColors) -> UIColor {
        let colorIndex = abs(hash % colors.count)
        return colors[colorIndex]
    }
}
#endif

import SwiftUI

public extension Color {
    static let avatarColors = [
        Color.InfomaniakColors.yellow,
        Color.InfomaniakColors.coral,
        Color.InfomaniakColors.grass,
        Color.InfomaniakColors.fougere,
        Color.InfomaniakColors.cobalt,
        Color.InfomaniakColors.jean,
        Color.InfomaniakColors.tropical,
        Color.InfomaniakColors.mauve,
        Color.InfomaniakColors.prince
    ]

    static func backgroundColor(from hash: Int, with colors: [Color] = Color.avatarColors) -> Color {
        let colorIndex = abs(hash % colors.count)
        return colors[colorIndex]
    }
}
