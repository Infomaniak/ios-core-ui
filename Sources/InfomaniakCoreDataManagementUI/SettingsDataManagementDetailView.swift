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

import InfomaniakCore
import InfomaniakCoreCommonUI
import InfomaniakCoreSwiftUI
import InfomaniakDI
import SwiftUI

@available(iOS 15.0, *)
struct SettingsDataManagementDetailView: View {
    let image: Image
    let title: LocalizedStringKey
    let description: LocalizedStringKey

    let matomoName: String

//    @AppStorage("toto") private var dataValue: Bool = true
    @State var dataValue: Bool = true

    init(image: Image, title: LocalizedStringKey, description: LocalizedStringKey, matomoName: String, appStorageKey: String) {
        self.image = image
        self.title = title
        self.description = description
        self.matomoName = matomoName
//        _dataValue = AppStorage(wrappedValue: false, appStorageKey)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                image
                    .padding(.vertical, value: .medium)
                    .frame(maxWidth: .infinity)

                Text(description, bundle: .module)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .padding(IKPadding.medium)

                Toggle(isOn: $dataValue) {
                    Text("settingsAuthorizeTracking", bundle: .module)
                        .font(.body)
                }
                .tint(.accentColor)
                .padding(IKPadding.medium)
            }
        }
        .background(Color("backgroundColor", bundle: .module))
        .navigationBarTitle(Text(title, bundle: .module), displayMode: .inline)
    }
}

@available(iOS 15.0, *)
extension SettingsDataManagementDetailView {
    static func matomo(appStorageKey: String) -> SettingsDataManagementDetailView {
        return SettingsDataManagementDetailView(
            image: Image("matomo-text", bundle: .module),
            title: "settingsMatomoTitle",
            description: "settingsMatomoDescription",
            matomoName: "matomo",
            appStorageKey: appStorageKey
        )
    }

    static func sentry(appStorageKey: String) -> SettingsDataManagementDetailView {
        return SettingsDataManagementDetailView(
            image: Image("sentry-text", bundle: .module),
            title: "settingsSentryTitle",
            description: "settingsSentryDescription",
            matomoName: "sentry",
            appStorageKey: appStorageKey
        )
    }
}

//@available(iOS 15.0, *)
//#Preview {
//    SettingsDataManagementDetailView.matomo
//}
