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
import InfomaniakCore
import SwiftUI

public extension View {
    @available(iOS 16.4, macOS 13.3, *)
    func floatingPanel<Content: View>(
        isPresented: Binding<Bool>,
        title: String? = nil,
        closeButtonHidden: Bool = false,
        backgroundColor: Color,
        topPadding: CGFloat = IKPadding.large,
        bottomPadding: CGFloat = IKPadding.medium,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        sheet(isPresented: isPresented) {
            content().modifier(SelfSizingPanelViewModifier(
                title: title,
                closeButtonHidden: closeButtonHidden,
                topPadding: topPadding,
                bottomPadding: bottomPadding
            ))
            .background(backgroundColor)
        }
    }

    @available(iOS 16.4, macOS 13.3, *)
    func floatingPanel<Item: Identifiable, Content: View>(
        item: Binding<Item?>,
        backgroundColor: Color,
        title: String? = nil,
        closeButtonHidden: Bool = false,
        topPadding: CGFloat = IKPadding.large,
        bottomPadding: CGFloat = IKPadding.medium,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View {
        sheet(item: item) { item in
            content(item)
                .modifier(SelfSizingPanelViewModifier(
                    title: title,
                    closeButtonHidden: closeButtonHidden,
                    topPadding: topPadding,
                    bottomPadding: bottomPadding
                ))
                .background(backgroundColor)
        }
    }
}
