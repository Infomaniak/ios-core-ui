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
        if title == nil && closeButtonHidden {
            return false
        }

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
    }
}
