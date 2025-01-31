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

import Foundation

/// An enumeration to list the paddings used for Infomaniak apps.
@frozen public enum IKPadding {
    @frozen public enum Option: CGFloat {
        /// 4pt padding
        case extraSmall = 4
        /// 8pt padding
        case small = 8
        /// 12pt padding
        case intermediate = 12
        /// 16pt padding
        case medium = 16
        /// 24pt padding
        case large = 24
        /// 48pt padding
        case extraLarge = 48
    }

    /// 4pt padding
    public static let extraSmall: CGFloat = 4
    /// 8pt padding
    public static let small: CGFloat = 8
    /// 12pt padding
    public static let intermediate: CGFloat = 12
    /// 16pt padding
    public static let medium: CGFloat = 16
    /// 24pt padding
    public static let large: CGFloat = 24
    /// 48pt padding
    public static let extraLarge: CGFloat = 48
}
