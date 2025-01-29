/*
 Infomaniak Mail - iOS App
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

import InfomaniakCoreCommonUI
import InfomaniakCoreSwiftUI
import SwiftUI

@available(iOS 15.0, *)
public struct SettingsDataManagementView: View {
    @Environment(\.openURL) private var openURL
    public let urlRepository: URL
    public let backgroundColor: Color
    public let dataPrivacyimage: Image
    public let userDefaultStore: UserDefaults
    public let userDefaultKeyMatomo: String
    public let userDefaultKeySentry: String

    public init(urlRepository: URL, backgroundColor: Color, dataPrivacyimage: Image, userDefaultStore: UserDefaults, userDefaultKeyMatomo: String, userDefaultKeySentry: String) {
        self.urlRepository = urlRepository
        self.backgroundColor = backgroundColor
        self.dataPrivacyimage = dataPrivacyimage
        self.userDefaultStore = userDefaultStore
        self.userDefaultKeyMatomo = userDefaultKeyMatomo
        self.userDefaultKeySentry = userDefaultKeySentry
    }

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                dataPrivacyimage
                    .padding(.bottom, value: .large)
                    .frame(maxWidth: .infinity)

                Text("settingsDataManagementDescription", bundle: .module)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, value: .medium)
                    .padding(.horizontal, value: .medium)

                Button(action: {
                    openURL(urlRepository)
                }) {
                    Text("settingsDataManagementSourceCode", bundle: .module)
                        .font(.headline)
                        .foregroundColor(Color.accentColor)
                }
                .buttonStyle(.ikBorderless(isInlined: true))
                .padding(IKPadding.medium)

                ForEach(DataType.allCases, id: \.self) { item in
                    DataSettingsSubMenuCell(title: item.title, image: item.image) {
                        switch item {
                        case .matomo:
                            SettingsDataManagementDetailView.matomo(appStorageKey: userDefaultKeyMatomo)
                        case .sentry:
                            SettingsDataManagementDetailView.sentry(appStorageKey: userDefaultKeySentry)
                        }
                    }

                    if item != DataType.allCases.last {
                        Divider().padding(IKPadding.medium)
                    }
                }
            }
        }
        .defaultAppStorage(userDefaultStore)
        .background(backgroundColor)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("settingsDataManagementTitle", bundle: .module)
                    .font(.headline)
            }
        }
    }
}

//@available(iOS 15.0, *)
//#Preview {
//    SettingsDataManagementView(urlRepository: URL, backgroundColor: Color, dataPrivacyimage: Image, userDefaultStore: UserDefaults, userDefaultKeyMatomo: String, userDefaultKeySentry: String)
//}
