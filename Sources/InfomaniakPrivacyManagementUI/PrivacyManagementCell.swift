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

import InfomaniakCoreSwiftUI
import SwiftUI

@available(iOS 15.0, *)
struct PrivacyManagementCell: View {
    let title: String
    var logoShort: Image?

    var body: some View {
        HStack(spacing: IKPadding.medium) {
            logoShort
                .padding(.leading, IKPadding.medium)

            Text(LocalizedStringKey(title), bundle: .module)
                .foregroundColor(Color("textPrimaryColor", bundle: .module))
                .frame(maxWidth: .infinity, alignment: .leading)

            Image("chevron-right", bundle: .module)
                .padding(.trailing, IKPadding.medium)
                .foregroundColor(Color("textSecondaryColor", bundle: .module))
        }
        .padding(.horizontal, value: .medium)
    }
}
