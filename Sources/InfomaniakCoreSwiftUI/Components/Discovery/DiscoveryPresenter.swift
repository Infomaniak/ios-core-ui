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

import DesignSystem
import SwiftUI

public extension View {
    func discoveryPresenter<ModalContent: View>(
        isPresented: Binding<Bool>,
        topPadding: CGFloat = IKPadding.large,
        bottomPadding: CGFloat = IKPadding.medium,
        alertBackgroundColor: Color,
        sheetBackgroundColor: Color,
        @ViewBuilder modalContent: @escaping () -> ModalContent
    ) -> some View {
        modifier(DiscoveryPresenter(
            isPresented: isPresented,
            topPadding: topPadding,
            bottomPadding: bottomPadding,
            alertBackgroundColor: alertBackgroundColor,
            sheetBackgroundColor: sheetBackgroundColor,
            modalContent: modalContent
        ))
    }
}

struct DiscoveryPresenter<ModalContent: View>: ViewModifier {
    @Environment(\.isCompactWindow) private var isCompactWindow

    @Binding var isPresented: Bool

    let topPadding: CGFloat
    let bottomPadding: CGFloat
    let alertBackgroundColor: Color
    let sheetBackgroundColor: Color
    @ViewBuilder let modalContent: ModalContent

    func body(content: Content) -> some View {
        content
            .sheet(isPresented: Binding(get: { isCompactWindow && isPresented }, set: { isPresented = $0 })) {
                if #available(iOS 16.0, *) {
                    modalContent.modifier(SelfSizingPanelViewModifier(topPadding: topPadding, bottomPadding: bottomPadding))
                        .background(sheetBackgroundColor)
                } else {
                    modalContent.modifier(SelfSizingPanelBackportViewModifier(
                        topPadding: topPadding,
                        bottomPadding: bottomPadding
                    ))
                    .background(sheetBackgroundColor)
                }
            }
            .customAlert(
                isPresented: Binding(get: { !isCompactWindow && isPresented }, set: { isPresented = $0 }),
                backgroundColor: alertBackgroundColor
            ) {
                modalContent
            }
    }
}
