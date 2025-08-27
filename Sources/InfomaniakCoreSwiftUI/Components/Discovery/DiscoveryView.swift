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
import InfomaniakCoreCommonUI
import InfomaniakCoreUIResources
import InfomaniakDI
import Lottie
import SwiftUI

public enum DiscoveryContent: Equatable {
    case image(Image)
    case lottie(name: String, bundle: Bundle)
}

public struct DiscoveryItem: Equatable {
    public let content: DiscoveryContent
    public let title: String
    public let description: String
    public let primaryButtonLabel: String
    public let shoulDisplayLaterButton: Bool

    public static func == (lhs: DiscoveryItem, rhs: DiscoveryItem) -> Bool {
        lhs.title == rhs.title && lhs.description == rhs.description
    }

    public init(
        content: DiscoveryContent,
        title: String,
        description: String,
        primaryButtonLabel: String,
        shouldDisplayLaterButton: Bool = false
    ) {
        self.content = content
        self.title = title
        self.description = description
        self.primaryButtonLabel = primaryButtonLabel
        shoulDisplayLaterButton = shouldDisplayLaterButton
    }
}

public struct DiscoveryView: View {
    @Environment(\.isCompactWindow) private var isCompactWindow
    @Environment(\.dismiss) private var dismiss

    @State private var willDiscoverNewFeature = false

    private let item: DiscoveryItem
    private var onAppear: (() -> Void)?
    private let completionHandler: (Bool) -> Void

    public init(
        item: DiscoveryItem,
        onAppear: (() -> Void)? = nil,
        completionHandler: @escaping (Bool) -> Void
    ) {
        self.item = item
        self.onAppear = onAppear
        self.completionHandler = completionHandler
    }

    public var body: some View {
        Group {
            if isCompactWindow {
                DiscoveryBottomSheetView(
                    item: item,
                    nowButton: didTouchNowButton,
                    laterButton: didTouchLaterButton
                )
            } else {
                DiscoveryAlertView(
                    item: item,
                    nowButton: didTouchNowButton,
                    laterButton: didTouchLaterButton
                )
            }
        }
        .onAppear {
            onAppear?()
        }
        .onDisappear {
            completionHandler(willDiscoverNewFeature)
        }
    }

    private func didTouchNowButton() {
        willDiscoverNewFeature = true
        dismiss()
    }

    private func didTouchLaterButton() {
        dismiss()
    }
}

struct DiscoveryBottomSheetView: View {
    let item: DiscoveryItem

    let nowButton: () -> Void
    let laterButton: () -> Void

    var body: some View {
        VStack(spacing: IKPadding.huge) {
            switch item.content {
            case .image(let image):
                image
            case .lottie(let animationName, let bundle):
                LottieView {
                    try await LottieAnimationSource.dotLottieFile(.named(animationName, bundle: bundle))
                }
                .playing(loopMode: .autoReverse)
                .frame(maxHeight: 128)
            }

            Text(item.title)
                .font(Font(TextStyle.header2.font))
                .foregroundColor(Color(TextStyle.header2.color))
                .multilineTextAlignment(.center)

            Text(item.description)
                .font(.body)
                .foregroundColor(Color(TextStyle.body2.color))
                .multilineTextAlignment(.center)

            VStack(spacing: IKPadding.mini) {
                Button(item.primaryButtonLabel, action: nowButton)
                    .buttonStyle(.ikBorderedProminent)

                if item.shoulDisplayLaterButton {
                    Button {
                        laterButton()
                    } label: {
                        Text(CoreUILocalizable.buttonLater)
                    }
                    .buttonStyle(.ikBorderless)
                }
            }
            .ikButtonFullWidth(true)
            .controlSize(.large)
        }
        .padding(.horizontal, value: .large)
        .padding(.top, value: .medium)
    }
}

struct DiscoveryAlertView: View {
    let item: DiscoveryItem

    let nowButton: () -> Void
    let laterButton: (() -> Void)?

    var body: some View {
        VStack(spacing: IKPadding.large) {
            switch item.content {
            case .image(let image):
                image
            case .lottie(let animationName, let bundle):
                LottieView {
                    try await LottieAnimationSource.dotLottieFile(.named(animationName, bundle: bundle))
                }
                .playing(loopMode: .autoReverse)
                .frame(maxHeight: 128)
            }

            Text(item.title)
                .font(.body)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)

            Text(item.description)
                .font(.body)
                .foregroundColor(Color(TextStyle.body2.color))
                .multilineTextAlignment(.center)

            if let laterButton {
                ModalButtonsView(
                    primaryButtonTitle: item.primaryButtonLabel,
                    secondaryButtonTitle: CoreUILocalizable.buttonLater,
                    primaryButtonAction: nowButton,
                    secondaryButtonAction: laterButton
                )
            } else {
                ModalButtonsView(
                    primaryButtonTitle: item.primaryButtonLabel,
                    primaryButtonAction: nowButton
                )
            }
        }
    }
}

#Preview {
    let item = DiscoveryItem(
        content: .image(Image("")),
        title: "Update available",
        description: "Update your app to get the latest features",
        primaryButtonLabel: "Update",
        shouldDisplayLaterButton: true
    )
    Group {
        DiscoveryBottomSheetView(item: item, nowButton: { /* Preview */ }, laterButton: { /* Preview */ })
        DiscoveryAlertView(item: item, nowButton: { /* Preview */ }, laterButton: { /* Preview */ })
        DiscoveryAlertView(item: item, nowButton: { /* Preview */ }, laterButton: { /* Preview */ })
    }
}
