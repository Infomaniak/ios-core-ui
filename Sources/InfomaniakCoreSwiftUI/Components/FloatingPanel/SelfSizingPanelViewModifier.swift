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

protocol SelfSizablePanel: ViewModifier {
    var dragIndicator: Visibility { get }
    var title: String? { get }
    var bottomPadding: CGFloat { get }

    var headerSize: CGFloat { get }
}

extension SelfSizablePanel {
    var headerSize: CGFloat {
        guard title != nil else {
            return IKFloatingPanelConstants.topPadding
        }
        return IKFloatingPanelConstants.topPadding + IKFloatingPanelConstants.titleSpacing +
            UIFont.preferredFont(forTextStyle: .headline).pointSize
    }
}

@available(iOS, introduced: 15, deprecated: 16, message: "Use native way")
public struct SelfSizingPanelBackportViewModifier: ViewModifier, SelfSizablePanel {
    @Environment(\.isCompactWindow) private var isCompactWindow

    @State private var currentDetents: Set<Backport.PresentationDetent> = [.medium]

    let dragIndicator: Visibility
    let title: String?
    let bottomPadding: CGFloat

    public init(dragIndicator: Visibility = Visibility.visible, title: String? = nil, bottomPadding: CGFloat) {
        self.dragIndicator = dragIndicator
        self.title = title
        self.bottomPadding = bottomPadding
    }

    public func body(content: Content) -> some View {
        IKFloatingPanelBackportView(
            title: title,
            bottomPadding: bottomPadding,
            detents: currentDetents,
            dragIndicator: dragIndicator
        ) {
            ScrollView {
                content
                    .padding(.bottom, bottomPadding)
            }
            .introspect(.scrollView, on: .iOS(.v15)) { scrollView in
                computeViewHeight(from: scrollView)
            }
        }
    }

    private func computeViewHeight(from scrollView: UIScrollView) {
        guard isCompactWindow, !currentDetents.contains(.large) else { return }

        let totalPanelContentHeight = scrollView.contentSize.height + headerSize

        scrollView.isScrollEnabled = totalPanelContentHeight > (scrollView.window?.bounds.height ?? 0)
        if totalPanelContentHeight > (scrollView.window?.bounds.height ?? 0) / 2 {
            currentDetents = [.medium, .large]
        }
    }
}

@available(iOS 16.0, *)
public struct SelfSizingPanelViewModifier: ViewModifier, SelfSizablePanel {
    @Environment(\.isCompactWindow) private var isCompactWindow

    @State private var currentDetents: Set<PresentationDetent> = [.height(0)]
    @State private var selection: PresentationDetent = .height(0)

    let dragIndicator: Visibility
    let title: String?
    let bottomPadding: CGFloat

    public init(dragIndicator: Visibility = Visibility.visible, title: String? = nil, bottomPadding: CGFloat) {
        self.dragIndicator = dragIndicator
        self.title = title
        self.bottomPadding = bottomPadding
    }

    public func body(content: Content) -> some View {
        IKFloatingPanelView(
            currentDetent: $selection,
            bottomPadding: bottomPadding,
            detents: currentDetents,
            dragIndicator: dragIndicator
        ) {
            ScrollView {
                content
                    .padding(.bottom, bottomPadding)
            }
            .introspect(.scrollView, on: .iOS(.v16, .v17, .v18, .v26)) { scrollView in
                computeViewHeight(from: scrollView)
            }
        }
    }

    private func computeViewHeight(from scrollView: UIScrollView) {
        guard isCompactWindow else { return }
        let totalPanelContentHeight = scrollView.contentSize.height + headerSize
        guard selection != .height(totalPanelContentHeight) else { return }

        scrollView.isScrollEnabled = totalPanelContentHeight > (scrollView.window?.bounds.height ?? 0)
        DispatchQueue.main.async {
            currentDetents = [.height(0), .height(totalPanelContentHeight)]
            selection = .height(totalPanelContentHeight)

            // Hack to let time for the animation to finish, after animation is complete we can modify the state again
            // if we don't do this the animation is cut before finishing
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                currentDetents = [selection]
            }
        }
    }
}
