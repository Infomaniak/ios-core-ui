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

/// An enumeration to list the size of icons used for Infomaniak apps.
@frozen public enum IKIconSize: CGFloat {
    /// 12pt icon
    case small = 12
    /// 16pt icon
    case medium = 16
    /// 24pt icon
    case large = 24
}

public extension Image {
    /// Resizes and scales the image to the specified ``IKIconSize`` size.
    /// - Parameter size: The specified size.
    /// - Returns: A square view containing the image scaled to fit in
    ///         a frame of the specified size.
    func iconSize(_ size: IKIconSize) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: size.rawValue, height: size.rawValue)
    }
}
