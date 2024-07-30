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
enum IKButtonHeight {
    static let extraLarge: CGFloat = 64
    static let large: CGFloat = 56
    static let medium: CGFloat = 40

    static func convert(controlSize: ControlSize) -> CGFloat {
        if controlSize == .large {
            return IKButtonHeight.large
        } else {
            return IKButtonHeight.medium
        }
    }
}
