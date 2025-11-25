//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.

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
