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
