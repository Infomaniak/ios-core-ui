/*
 Infomaniak Core UI - iOS
 Copyright (C) 2024 Infomaniak Network SA

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

import InfomaniakCoreSwiftUI
import SwiftUI

@available(iOS 15.0, *)
public struct MyKSuiteView: View {
    @Environment(\.dismiss) private var dismiss

    let configuration: [MyKSuiteLabel]

    public var body: some View {
        VStack(spacing: 32) {
            Image("gradient", bundle: .module)
                .resizable()
                .frame(maxWidth: .infinity)
                .frame(height: 90)
                .overlay {
                    Image("logo", bundle: .module)
                }

            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading, spacing: IKPadding.medium) {
                    Text("title", bundle: .module)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color("orca", bundle: .module))
                        .frame(maxWidth: .infinity, alignment: .center)

                    Text("description", bundle: .module)
                }

                VStack(alignment: .leading, spacing: IKPadding.medium) {
                    ForEach(configuration) { label in
                        Label {
                            Text(label.text)
                        } icon: {
                            label.icon
                        }
                    }
                }

                Text("details", bundle: .module)

                Button {
                    dismiss()
                } label: {
                    Text("close", bundle: .module)
                }
                .ikButtonFullWidth(true)
                .controlSize(.large)
                .buttonStyle(.ikBorderedProminent)
            }
            .padding(.horizontal, value: .large)
            .font(.system(size: 16, weight: .regular))
            .foregroundStyle(Color("elephant", bundle: .module))
        }
    }
}

@available(iOS 15.0, *)
#Preview("kDrive") {
    MyKSuiteView(configuration: [])
}

@available(iOS 15.0, *)
#Preview("Mail") {
    MyKSuiteView(configuration: [])
}
