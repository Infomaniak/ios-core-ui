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
    let maximumStepCount: Int
    let minimumStepSize: Int
    let title: String?
    let closeButtonHidden: Bool
    let topPadding: CGFloat
    let bottomPadding: CGFloat

    public init(
        dragIndicator: Visibility = Visibility.visible,
        maximumStepCount: Int = 1,
        minimumStepSize: Int = 256,
        title: String? = nil,
        closeButtonHidden: Bool = false,
        topPadding: CGFloat,
        bottomPadding: CGFloat
    ) {
        self.dragIndicator = dragIndicator
        self.maximumStepCount = maximumStepCount
        self.minimumStepSize = minimumStepSize
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

        let detentHeights = computeStepsFor(contentHeight: totalPanelContentHeight)

        let newCurrentDetents = detentHeights.map { PresentationDetent.height(CGFloat($0)) }
        guard Set(newCurrentDetents) != currentDetents else { return }

        let newSelection: PresentationDetent = newCurrentDetents.first ?? .height(totalPanelContentHeight)

        DispatchQueue.main.async {
            currentDetents = Set([.height(Self.defaultHeight)]).union(newCurrentDetents)
            if selection == .height(Self.defaultHeight) || !currentDetents.contains(selection) {
                selection = newSelection
            }

            // Hack to let time for the animation to finish, after animation is complete we can modify the state again
            // if we don't do this the animation is cut before finishing
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                currentDetents = Set(newCurrentDetents)
            }
        }
    }

    private func computeStepsFor(contentHeight: CGFloat) -> [Int] {
        var stepHeights: [Int] = [Int(contentHeight)]

        for step in (1 ..< maximumStepCount).reversed() {
            let nextStepHeight = Int(CGFloat(step) / CGFloat(maximumStepCount) * contentHeight)
            if nextStepHeight < (stepHeights.last ?? 0) - minimumStepSize {
                stepHeights.insert(nextStepHeight, at: 0)
            }
        }

        return stepHeights
    }
}
