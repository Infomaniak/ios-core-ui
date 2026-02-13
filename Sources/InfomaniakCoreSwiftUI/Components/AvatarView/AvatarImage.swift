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

public struct AvatarImage: View {
    let backgroundColor: Color
    let image: Image
    let size: CGFloat

    public init(backgroundColor: Color = .white, image: Image, size: CGFloat) {
        self.backgroundColor = backgroundColor
        self.image = image
        self.size = size
    }

    public var body: some View {
        ZStack {
            backgroundColor

            image
                .resizable()
                .scaledToFill()
        }
        .frame(width: size, height: size)
        .clipShape(.circle)
        .drawingGroup()
    }
}

@available(iOS 16.0, *)
#Preview {
    @MainActor func getImage(withSize size: CGSize) -> Image {
        let square = Rectangle()
            .fill(.blue)
            .frame(width: size.width, height: size.height)

        let uiImage = ImageRenderer(content: square).uiImage!
        return Image(uiImage: uiImage)
    }

    let showBorder = true

    return VStack {
        AvatarImage(image: getImage(withSize: CGSize(width: 40, height: 40)), size: 40)
            .border(showBorder ? .red : .clear)

        AvatarImage(image: getImage(withSize: CGSize(width: 60, height: 40)), size: 40)
            .border(showBorder ? .red : .clear)

        AvatarImage(image: getImage(withSize: CGSize(width: 40, height: 60)), size: 40)
            .border(showBorder ? .red : .clear)
    }
}
