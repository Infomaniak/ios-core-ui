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
import SwiftUIBackports

public enum IKFloatingPanelConstants {
    public static let titleSpacing = IKPadding.mini
}

@available(iOS, introduced: 15, deprecated: 16, message: "Use native way")
public struct IKFloatingPanelBackportView<Content: View>: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.isCompactWindow) private var isCompactWindow

    let title: String?
    let closeButtonHidden: Bool
    let topPadding: CGFloat
    let bottomPadding: CGFloat
    let detents: Set<Backport<Any>.PresentationDetent>
    let dragIndicator: Visibility
    let content: Content

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

    private var isCompactMode: Bool {
        return !isCompactWindow || (UIDevice.current.orientation.isLandscape && UIDevice.current.userInterfaceIdiom != .pad)
    }

    private var shouldShowHeader: Bool {
        return title != nil || isCompactMode
    }

    public init(
        title: String? = nil,
        closeButtonHidden: Bool = false,
        topPadding: CGFloat,
        bottomPadding: CGFloat,
        detents: Set<Backport<Any>.PresentationDetent>,
        dragIndicator: Visibility,
        @ViewBuilder content: () -> Content,
    ) {
        self.title = title
        self.closeButtonHidden = closeButtonHidden
        self.topPadding = topPadding
        self.bottomPadding = bottomPadding
        self.detents = detents
        self.dragIndicator = dragIndicator
        self.content = content()
    }

    public var body: some View {
        VStack(spacing: IKPadding.mini) {
            if shouldShowHeader {
                ZStack {
                    if let title {
                        Text(title)
                            .font(Font(UIFont.preferredFont(forTextStyle: .headline)))
                    }

                    if isCompactMode && !closeButtonHidden {
                        FloatingPanelCloseButton(size: .medium, dismissAction: dismiss)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, value: .medium)
                    }
                }
            }

            content
        }
        .padding(.top, topPadding)
        .padding(.bottom, bottomPadding)
        .backport.presentationDragIndicator(isCompactWindow ? backportDragIndicator : .hidden)
        .backport.presentationDetents(isCompactWindow ? detents : [.large])
        .ikPresentationCornerRadius(20)
    }
}

@available(iOS 16.0, *)
public struct IKFloatingPanelView<Content: View>: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.isCompactWindow) private var isCompactWindow

    @Binding var currentDetent: PresentationDetent

    let title: String?
    let closeButtonHidden: Bool
    let topPadding: CGFloat
    let bottomPadding: CGFloat
    let detents: Set<PresentationDetent>
    let dragIndicator: Visibility
    let content: Content

    private var isCompactMode: Bool {
        return !isCompactWindow || (UIDevice.current.orientation.isLandscape && UIDevice.current.userInterfaceIdiom != .pad)
    }

    private var shouldShowHeader: Bool {
        return title != nil || isCompactMode
    }

    public init(
        currentDetent: Binding<PresentationDetent>,
        title: String? = nil,
        closeButtonHidden: Bool = false,
        topPadding: CGFloat,
        bottomPadding: CGFloat,
        detents: Set<PresentationDetent>,
        dragIndicator: Visibility,
        @ViewBuilder content: () -> Content,
    ) {
        _currentDetent = currentDetent
        self.title = title
        self.closeButtonHidden = closeButtonHidden
        self.topPadding = topPadding
        self.bottomPadding = bottomPadding
        self.detents = detents
        self.dragIndicator = dragIndicator
        self.content = content()
    }

    public var body: some View {
        VStack(spacing: IKPadding.mini) {
            if shouldShowHeader {
                ZStack {
                    if let title {
                        Text(title)
                            .font(Font(UIFont.preferredFont(forTextStyle: .headline)))
                    }

                    if isCompactMode && !closeButtonHidden {
                        FloatingPanelCloseButton(size: .medium, dismissAction: dismiss)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, value: .medium)
                    }
                }
            }

            content
        }
        .padding(.top, topPadding)
        .padding(.bottom, bottomPadding)
        .presentationDetents(isCompactWindow ? detents : [.large], selection: $currentDetent)
        .presentationDragIndicator(isCompactWindow ? dragIndicator : .hidden)
        .ikPresentationCornerRadius(20)
    }
}
