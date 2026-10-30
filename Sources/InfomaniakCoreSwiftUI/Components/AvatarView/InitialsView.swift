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

import SwiftUI

public struct InitialsView: View {
    let initials: String
    let backgroundColor: Color
    let foregroundColor: Color

    public init(initials: String, backgroundColor: Color, foregroundColor: Color) {
        self.initials = initials
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }

    public var body: some View {
        Circle()
            .fill(backgroundColor)
            .overlay {
                GeometryReader { proxy in
                    Text(initials)
                        .font(.system(size: proxy.size.width * 0.5, weight: .semibold))
                        .foregroundStyle(foregroundColor)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .compositingGroup()
    }
}

#Preview {
    HStack {
        InitialsView(initials: "TE", backgroundColor: .red, foregroundColor: .white)
            .frame(width: 16, height: 16)

        InitialsView(initials: "TE", backgroundColor: .red, foregroundColor: .white)
            .frame(width: 40, height: 40)

        InitialsView(initials: "TE", backgroundColor: .red, foregroundColor: .white)
            .frame(width: 100, height: 100)
    }
}
