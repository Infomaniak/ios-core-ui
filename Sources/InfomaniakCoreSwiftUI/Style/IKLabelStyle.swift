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

import DesignSystem
import SwiftUI

@available(iOS 15.0, *)
public struct IKLabelStyle: LabelStyle {
    var spacing = IKPadding.small

    public func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: spacing) {
            configuration.icon
            configuration.title
        }
    }
}

@available(iOS 15.0, *)
public extension LabelStyle where Self == IKLabelStyle {
    static var ikLabel: IKLabelStyle {
        return IKLabelStyle()
    }

    static func ikLabel(_ spacing: CGFloat) -> IKLabelStyle {
        return IKLabelStyle(spacing: spacing)
    }
}
