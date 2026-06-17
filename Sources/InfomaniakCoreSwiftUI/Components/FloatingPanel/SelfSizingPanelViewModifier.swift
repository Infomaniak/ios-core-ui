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
import InfomaniakCore
import InfomaniakDI
import SwiftUI
import SwiftUIBackports
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

protocol SelfSizablePanel: ViewModifier {
    var dragIndicator: Visibility { get }
    var title: String? { get }
    var topPadding: CGFloat { get }
    var bottomPadding: CGFloat { get }

    var headerSize: CGFloat { get }
}

private var headlinePointSize: CGFloat {
    #if canImport(UIKit)
    return UIFont.preferredFont(forTextStyle: .headline).pointSize
    #elseif canImport(AppKit)
    return NSFont.preferredFont(forTextStyle: .headline).pointSize
    #endif
}

extension SelfSizablePanel {
    var headerSize: CGFloat {
        guard title != nil else {
            return topPadding
        }
        return topPadding + IKFloatingPanelConstants.titleSpacing + headlinePointSize
    }
}

@available(iOS 16.4, macOS 13.3, *)
public struct SelfSizingPanelViewModifier: ViewModifier, SelfSizablePanel {
    static let defaultHeight: CGFloat = 1

    @Environment(\.isCompactWindow) private var isCompactWindow

    @State private var currentDetents: Set<PresentationDetent> = [.height(Self.defaultHeight)]
    @State private var selection: PresentationDetent = .height(Self.defaultHeight)

    let dragIndicator: Visibility
    let title: String?
    let closeButtonHidden: Bool
    let topPadding: CGFloat
    let bottomPadding: CGFloat

    public init(
        dragIndicator: Visibility = Visibility.visible,
        title: String? = nil,
        closeButtonHidden: Bool = false,
        topPadding: CGFloat,
        bottomPadding: CGFloat
    ) {
        self.dragIndicator = dragIndicator
        self.title = title
        self.closeButtonHidden = closeButtonHidden
        self.topPadding = topPadding
        self.bottomPadding = bottomPadding
    }

    public func body(content: Content) -> some View {
        IKFloatingPanelView(
            currentDetent: $selection,
            title: title,
            closeButtonHidden: closeButtonHidden,
            topPadding: topPadding,
            bottomPadding: 0,
            detents: currentDetents,
            dragIndicator: dragIndicator
        ) {
            ScrollView {
                content
                    .padding(.bottom, bottomPadding)
                    .onGeometryChange(for: CGFloat.self) { proxy in
                        return proxy.size.height + headerSize + bottomPadding
                    } action: { totalPanelContentHeight in
                        DispatchQueue.main.async {
                            let customHeightDetent: PresentationDetent = .height(totalPanelContentHeight)
                            currentDetents = [customHeightDetent]
                            selection = customHeightDetent
                        }
                    }
            }
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}
