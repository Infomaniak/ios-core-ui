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
    @AppStorage private var dataValue: Bool

    @Environment(\.dismiss) private var dismiss

    let dataType: DataType

    init(dataType: DataType, appStorageKey: String) {
        self.dataType = dataType
        _dataValue = AppStorage(wrappedValue: false, appStorageKey)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    dataType.imageText
                        .padding(.vertical, value: .medium)
                        .frame(maxWidth: .infinity)

                    Text(LocalizedStringKey(dataType.description), bundle: .module)
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
            .navigationBarTitle(Text(LocalizedStringKey(dataType.title), bundle: .module), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
        }
    }
}

@available(iOS 15.0, *)
extension SettingsDataManagementDetailView {
    static func create(for dataType: DataType, appStorageKey: String) -> SettingsDataManagementDetailView {
        return SettingsDataManagementDetailView(dataType: dataType, appStorageKey: appStorageKey)
    }
}

// @available(iOS 15.0, *)
// #Preview {
//    SettingsDataManagementDetailView.matomo
// }
