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
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public enum IKFloatingPanelConstants {
    public static let titleSpacing = IKPadding.mini
}

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
        #if canImport(UIKit)
        return !isCompactWindow || (UIDevice.current.orientation.isLandscape && UIDevice.current.userInterfaceIdiom != .pad)
        #elseif canImport(AppKit)
        return !isCompactWindow
        #endif
    }

    private var shouldShowHeader: Bool {
        if title == nil && closeButtonHidden {
            return false
        }

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

    private var headlinePointSize: Font {
        #if canImport(UIKit)
        return Font(UIFont.preferredFont(forTextStyle: .headline))
        #elseif canImport(AppKit)
        return Font(NSFont.preferredFont(forTextStyle: .headline))
        #endif
    }

    public var body: some View {
        VStack(spacing: IKPadding.mini) {
            if shouldShowHeader {
                ZStack {
                    if let title {
                        Text(title)
                            .font(headlinePointSize)
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
    }
}
