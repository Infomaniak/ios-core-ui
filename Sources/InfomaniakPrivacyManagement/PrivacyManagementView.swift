/*
 Infomaniak Core UI - iOS
 Copyright (C) 2025 Infomaniak Network SA

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import DesignSystem
import InfomaniakCoreCommonUI
import InfomaniakCoreSwiftUI
import SwiftUI

public protocol MatomoOptOutable {
    func optOut(_ optOut: Bool)
}

extension MatomoUtils: MatomoOptOutable {}

@available(iOS 15.0, *)
public struct PrivacyManagementView: View {
    public static let title = Bundle.module.localizedString(forKey: "trackingManagementTitle", value: nil, table: nil)

    @AppStorage private var matomoAuthorized: Bool

    @Environment(\.openURL) private var openURL

    @State private var selectedDataType: Tracker?

    private let urlRepository: URL
    private let backgroundColor: Color
    private let illustration: Image
    private let userDefaultStore: UserDefaults
    private let userDefaultKeyMatomo: String
    private let userDefaultKeySentry: String
    private let showTitle: Bool
    private let matomo: MatomoOptOutable

    public init(
        urlRepository: URL,
        backgroundColor: Color,
        illustration: Image,
        userDefaultStore: UserDefaults,
        userDefaultKeyMatomo: String,
        userDefaultKeySentry: String,
        showTitle: Bool = true,
        matomo: MatomoOptOutable
    ) {
        self.urlRepository = urlRepository
        self.backgroundColor = backgroundColor
        self.illustration = illustration
        self.userDefaultStore = userDefaultStore
        self.userDefaultKeyMatomo = userDefaultKeyMatomo
        self.userDefaultKeySentry = userDefaultKeySentry
        self.showTitle = showTitle
        self.matomo = matomo
        _matomoAuthorized = AppStorage(wrappedValue: true, userDefaultKeyMatomo)
    }

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                illustration
                    .padding(IKPadding.medium)
                    .frame(maxWidth: .infinity)

                Text("trackingManagementDescription", bundle: .module)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, IKPadding.medium)

                Button {
                    openURL(urlRepository)
                } label: {
                    Text("applicationSourceCode", bundle: .module)
                        .font(.headline)
                }
                .buttonStyle(.ikBorderless(isInlined: true))
                .padding(IKPadding.medium)

                ForEach(Tracker.allCases, id: \.self) { item in
                    Button {
                        selectedDataType = item
                    } label: {
                        PrivacyManagementCell(title: item.title, image: item.logoShort)
                    }
                    .sheet(item: $selectedDataType) { selectedItem in
                        TrackerDetailsView(
                            tracker: selectedItem,
                            appStorageKey: selectedItem == .matomo ? userDefaultKeyMatomo : userDefaultKeySentry,
                            backgroundColor: backgroundColor
                        )
                    }

                    if item != Tracker.allCases.last {
                        Divider()
                            .padding(.horizontal, IKPadding.medium)
                    }
                }
            }
        }
        // Padding is for smaller iPhones like the SE.
        .padding(.bottom, IKPadding.huge)
        .background(backgroundColor)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(showTitle ? Self.title : "")
        .onChange(of: matomoAuthorized) { newValue in
            #if DEBUG || TEST
            matomo.optOut(true)
            #else
            matomo.optOut(!newValue)
            #endif
        }
    }
}

@available(iOS 15.0, *)
#Preview {
    return PrivacyManagementView(
        urlRepository: URL(string: "https://www.infomaniak.com")!,
        backgroundColor: Color.white,
        illustration: Image(""),
        userDefaultStore: UserDefaults.standard,
        userDefaultKeyMatomo: "",
        userDefaultKeySentry: "",
        showTitle: true,
        matomo: MatomoUtils(siteId: "", baseURL: URL(string: "")!) as MatomoOptOutable
    )
}
