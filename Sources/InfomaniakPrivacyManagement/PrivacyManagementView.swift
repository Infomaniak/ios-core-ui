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

@available(iOS 15.0, *)
public struct PrivacyManagementView: View {
    public static let title = Bundle.module.localizedString(forKey: "trackingManagementTitle", value: nil, table: nil)

    @AppStorage private var matomoAuthorized: Bool

    @Environment(\.openURL) private var openURL

    @State private var selectedDataType: Tracker?

    private let urlRepository: URL
    private let backgroundColor: Color
    private let groupedStyle: Bool
    private let illustration: Image
    private let userDefaultStore: UserDefaults
    private let userDefaultKeyMatomo: String
    private let userDefaultKeySentry: String
    private let showTitle: Bool
    private let matomo: MatomoOptOutable

    public init(
        urlRepository: URL,
        backgroundColor: Color,
        groupedStyle: Bool = false,
        illustration: Image,
        userDefaultStore: UserDefaults,
        userDefaultKeyMatomo: String,
        userDefaultKeySentry: String,
        showTitle: Bool = true,
        matomo: MatomoOptOutable
    ) {
        self.urlRepository = urlRepository
        self.backgroundColor = backgroundColor
        self.groupedStyle = groupedStyle
        self.illustration = illustration
        self.userDefaultStore = userDefaultStore
        self.userDefaultKeyMatomo = userDefaultKeyMatomo
        self.userDefaultKeySentry = userDefaultKeySentry
        self.showTitle = showTitle
        self.matomo = matomo
        _matomoAuthorized = AppStorage(wrappedValue: true, userDefaultKeyMatomo)
    }

    private var list: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 0) {
                    illustration
                        .padding(IKPadding.medium)
                        .frame(maxWidth: .infinity)

                    Text("trackingManagementDescription", bundle: .module)
                        .multilineTextAlignment(.leading)

                    Button {
                        openURL(urlRepository)
                    } label: {
                        Text("applicationSourceCode", bundle: .module)
                            .font(.headline)
                    }
                    .buttonStyle(.ikBorderless(isInlined: true))
                    .padding([.vertical], value: .medium)
                }
            }
            .listRowBackground(Color.clear)
            .listSectionSeparator(.hidden)

            Section {
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
                }
            }
        }
    }

    public var body: some View {
        Group {
            if #available(iOS 16.0, *) {
                if groupedStyle {
                    list
                        .scrollContentBackground(.hidden)
                        .background(backgroundColor)
                        .listStyle(.insetGrouped)
                } else {
                    list
                        .listStyle(.plain)
                }
            } else {
                if groupedStyle {
                    list
                        .listStyle(.insetGrouped)
                } else {
                    list
                        .listStyle(.plain)
                }
            }
        }
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
    if let validURL = URL(string: "https://www.infomaniak.com/matomo.php") {
        PrivacyManagementView(
            urlRepository: validURL,
            backgroundColor: Color.white,
            groupedStyle: true,
            illustration: Image("matomo-short", bundle: .module),
            userDefaultStore: UserDefaults.standard,
            userDefaultKeyMatomo: "matomoKey",
            userDefaultKeySentry: "sentryKey",
            showTitle: true,
            matomo: MatomoUtils(siteId: "yourSiteId", baseURL: validURL)
        )
    } else {
        Text("Invalid URL")
    }
}
