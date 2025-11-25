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
import InfomaniakCore
import InfomaniakDI
import SwiftUI
import SwiftUIBackports

protocol SelfSizablePanel: ViewModifier {
    var dragIndicator: Visibility { get }
    var title: String? { get }
    var topPadding: CGFloat { get }
    var bottomPadding: CGFloat { get }

    var headerSize: CGFloat { get }
}

extension SelfSizablePanel {
    var headerSize: CGFloat {
        guard title != nil else {
            return topPadding
        }
        return topPadding + IKFloatingPanelConstants.titleSpacing +
            UIFont.preferredFont(forTextStyle: .headline).pointSize
    }
}

@available(iOS, introduced: 15, deprecated: 16, message: "Use native way")
public struct SelfSizingPanelBackportViewModifier: ViewModifier, SelfSizablePanel {
    @Environment(\.isCompactWindow) private var isCompactWindow

    @State private var currentDetents: Set<Backport.PresentationDetent> = [.medium]

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
        IKFloatingPanelBackportView(
            title: title,
            topPadding: topPadding,
            bottomPadding: 0,
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
            currentDetents = [.height(Self.defaultHeight), .height(totalPanelContentHeight)]
            selection = .height(totalPanelContentHeight)

            // Hack to let time for the animation to finish, after animation is complete we can modify the state again
            // if we don't do this the animation is cut before finishing
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                currentDetents = [selection]
            }
        }
    }
}
