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
import InfomaniakCoreCommonUI
import InfomaniakCoreUIResources
import InfomaniakDI
import Lottie
import SwiftUI

public enum DiscoveryContent: Equatable {
    case image(Image)
    case lottie(lightName: String, darkName: String? = nil, bundle: Bundle)
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
            case .lottie(let lightAnimationName, let darkAnimationName, let bundle):
                ThemedLottieView(lightAnimationName: lightAnimationName, darkAnimationName: darkAnimationName, bundle: bundle)
                    .frame(height: 128)
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
            case .lottie(let lightAnimationName, let darkAnimationName, let bundle):
                ThemedLottieView(lightAnimationName: lightAnimationName, darkAnimationName: darkAnimationName, bundle: bundle)
                    .frame(height: 128)
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
