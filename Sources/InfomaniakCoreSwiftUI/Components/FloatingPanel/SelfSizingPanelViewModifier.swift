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
            }
            #if canImport(UIKit)
            .introspect(.scrollView, on: .iOS(.v16, .v17, .v18, .v26, .v27)) { scrollView in
                computeViewHeight(from: scrollView)
            }
            #endif
        }
    }

    #if canImport(UIKit)
    private func computeViewHeight(from scrollView: UIScrollView) {
        guard isCompactWindow else { return }
        let totalPanelContentHeight = scrollView.contentSize.height + headerSize
        guard selection != .height(totalPanelContentHeight) else { return }

        scrollView.isScrollEnabled = totalPanelContentHeight > (scrollView.window?.bounds.height ?? 0)
        DispatchQueue.main.async {
            currentDetents = [.height(Self.defaultHeight), .height(totalPanelContentHeight)]
            selection = .height(totalPanelContentHeight)

            // Hack to let time for the animation to finish, after animation is complete we can modify the state again
            // if we don't do this the animation is cut before finishing
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                currentDetents = [selection]
            }
        }
    }
    #endif
}
