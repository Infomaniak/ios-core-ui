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
import InfomaniakDI
import SwiftUI
import SwiftUIBackports
import SwiftUIIntrospect

@available(iOS 15, *)
public extension View {
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
            if #available(iOS 16.0, *) {
                content().modifier(SelfSizingPanelViewModifier(
                    title: title,
                    closeButtonHidden: closeButtonHidden,
                    topPadding: topPadding,
                    bottomPadding: bottomPadding
                ))
                .sheetBackgroundIfNecessary(backgroundColor)
            } else {
                content().modifier(SelfSizingPanelBackportViewModifier(
                    title: title,
                    closeButtonHidden: closeButtonHidden,
                    topPadding: topPadding,
                    bottomPadding: bottomPadding
                ))
                .sheetBackgroundIfNecessary(backgroundColor)
            }
        }
    }

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
            if #available(iOS 16.0, *) {
                content(item)
                    .modifier(SelfSizingPanelViewModifier(
                        title: title,
                        closeButtonHidden: closeButtonHidden,
                        topPadding: topPadding,
                        bottomPadding: bottomPadding
                    ))
                    .sheetBackgroundIfNecessary(backgroundColor)
            } else {
                content(item)
                    .modifier(SelfSizingPanelBackportViewModifier(
                        title: title,
                        closeButtonHidden: closeButtonHidden,
                        topPadding: topPadding,
                        bottomPadding: bottomPadding
                    ))
                    .sheetBackgroundIfNecessary(backgroundColor)
            }
        }
    }

    @ViewBuilder private func sheetBackgroundIfNecessary(_ color: Color) -> some View {
        if #available(iOS 26.0, *) {
            self
        } else {
            background(color)
        }
    }
}
