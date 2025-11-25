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
import InfomaniakCoreCommonUI
import InfomaniakCoreUIResources
import InfomaniakDI
import SwiftUI

public struct AskForReviewView: View {
    private let appName: String
    private let feedbackURL: String
    private let onLike: () async throws -> Void
    private let onDislike: (URL) -> Void
    private let reviewManager: ReviewManageable

    public init(
        appName: String,
        feedbackURL: String,
        reviewManager: ReviewManageable,
        onLike: @escaping () async throws -> Void,
        onDislike: @escaping (URL) -> Void
    ) {
        self.appName = appName
        self.feedbackURL = feedbackURL
        self.reviewManager = reviewManager
        self.onLike = onLike
        self.onDislike = onDislike
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(CoreUILocalizable.reviewAlertTitle(appName))
                .padding(.bottom, IKPadding.large)

            ModalButtonsView(
                primaryButtonTitle: CoreUILocalizable.buttonYes,
                secondaryButtonTitle: CoreUILocalizable.buttonNo,
                primaryButtonAction: {
                    try await onLike()
                    reviewManager.requestReview()
                },
                secondaryButtonAction: {
                    if let userReportURL = URL(string: feedbackURL) {
                        onDislike(userReportURL)
                    }
                }
            )
        }
    }
}

#Preview {
    AskForReviewView(
        appName: "InfomaniakCoreUI ",
        feedbackURL: "https://infomaniak.com",
        reviewManager: ReviewManager(
            userDefaults: UserDefaults.standard,
            openingBeforeFirstReview: 1,
            openingBeforeNextReviews: 2
        ),
        onLike: {},
        onDislike: { _ in
        }
    )
}
