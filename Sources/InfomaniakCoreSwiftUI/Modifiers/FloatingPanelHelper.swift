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
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        sheet(isPresented: isPresented) {
            if #available(iOS 16.0, *) {
                content().modifier(SelfSizingPanelViewModifier(title: title))
            } else {
                content().modifier(SelfSizingPanelBackportViewModifier(title: title))
            }
        }
    }

    func floatingPanel<Item: Identifiable, Content: View>(
        item: Binding<Item?>,
        title: String? = nil,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View {
        sheet(item: item) { item in
            if #available(iOS 16.0, *) {
                content(item).modifier(SelfSizingPanelViewModifier(title: title))
            } else {
                content(item).modifier(SelfSizingPanelBackportViewModifier(title: title))
            }
        }
    }

    @MainActor
    func ikPresentationCornerRadius(_ cornerRadius: CGFloat?) -> some View {
        if #available(iOS 16.4, *) {
            return presentationCornerRadius(cornerRadius)
        } else {
            return introspect(.viewController, on: .iOS(.v15)) { viewController in
                viewController.sheetPresentationController?.preferredCornerRadius = cornerRadius
            }
        }
    }
}

@available(iOS, introduced: 15, deprecated: 16, message: "Use native way")
public struct SelfSizingPanelBackportViewModifier: ViewModifier {
    @LazyInjectService private var platformDetector: PlatformDetectable

    @Environment(\.dismiss) private var dismiss

    @State private var currentDetents: Set<Backport.PresentationDetent> = [.medium]

    let dragIndicator: Visibility
    let title: String?

    private let topPadding = IKPadding.large
    private let titleSpacing = IKPadding.small

    private var backportDragIndicator: Backport<Any>.Visibility {
        switch dragIndicator {
        case .automatic:
            return .automatic
        case .visible:
            return .visible
        case .hidden:
            return .hidden
        }
    }

    private var headerSize: CGFloat {
        guard title != nil else {
            return topPadding
        }
        return topPadding + titleSpacing + UIFont.preferredFont(forTextStyle: .headline).pointSize
    }

    private var shouldShowCloseButton: Bool {
        return platformDetector.isMac || (UIDevice.current.orientation.isLandscape && UIDevice.current.userInterfaceIdiom != .pad)
    }

    private var shouldShowHeader: Bool {
        return title != nil || shouldShowCloseButton
    }

    public init(dragIndicator: Visibility = Visibility.visible, title: String? = nil) {
        self.dragIndicator = dragIndicator
        self.title = title
    }

    public func body(content: Content) -> some View {
        VStack(spacing: IKPadding.small) {
            if shouldShowHeader {
                ZStack {
                    if let title {
                        Text(title)
                            .font(Font(UIFont.preferredFont(forTextStyle: .headline)))
                    }

                    if shouldShowCloseButton {
                        FloatingPanelCloseButton(size: .medium, dismissAction: dismiss)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, value: .medium)
                    }
                }
            }

            ScrollView {
                content
                    .padding(.bottom, value: .medium)
            }
            .introspect(.scrollView, on: .iOS(.v15)) { scrollView in
                guard !currentDetents.contains(.large) else { return }
                let totalPanelContentHeight = scrollView.contentSize.height + headerSize

                scrollView.isScrollEnabled = totalPanelContentHeight > (scrollView.window?.bounds.height ?? 0)
                if totalPanelContentHeight > (scrollView.window?.bounds.height ?? 0) / 2 {
                    currentDetents = [.medium, .large]
                }
            }
        }
        .padding(.top, topPadding)
        .backport.presentationDragIndicator(backportDragIndicator)
        .backport.presentationDetents(currentDetents)
        .ikPresentationCornerRadius(20)
    }
}

@available(iOS 16.0, *)
public struct SelfSizingPanelViewModifier: ViewModifier {
    @LazyInjectService private var platformDetector: PlatformDetectable

    @Environment(\.dismiss) private var dismiss

    @State private var currentDetents: Set<PresentationDetent> = [.height(0)]
    @State private var selection: PresentationDetent = .height(0)

    let dragIndicator: Visibility
    let title: String?

    private let topPadding = IKPadding.large
    private let titleSpacing = IKPadding.small

    private var headerSize: CGFloat {
        guard title != nil else {
            return topPadding
        }
        return topPadding + titleSpacing + UIFont.preferredFont(forTextStyle: .headline).pointSize
    }

    private var shouldShowCloseButton: Bool {
        return platformDetector.isMac || (UIDevice.current.orientation.isLandscape && UIDevice.current.userInterfaceIdiom != .pad)
    }

    private var shouldShowHeader: Bool {
        return title != nil || shouldShowCloseButton
    }

    public init(dragIndicator: Visibility = Visibility.visible, title: String? = nil) {
        self.dragIndicator = dragIndicator
        self.title = title
    }

    public func body(content: Content) -> some View {
        VStack(spacing: titleSpacing) {
            if shouldShowHeader {
                ZStack {
                    if let title {
                        Text(title)
                            .font(Font(UIFont.preferredFont(forTextStyle: .headline)))
                    }

                    if shouldShowCloseButton {
                        FloatingPanelCloseButton(size: .medium, dismissAction: dismiss)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, value: .medium)
                    }
                }
            }

            ScrollView {
                content
                    .padding(.bottom, value: .medium)
            }
            .introspect(.scrollView, on: .iOS(.v16, .v17, .v18)) { scrollView in
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
        .padding(.top, topPadding)
        .presentationDetents(currentDetents, selection: $selection)
        .presentationDragIndicator(dragIndicator)
        .ikPresentationCornerRadius(20)
    }
}