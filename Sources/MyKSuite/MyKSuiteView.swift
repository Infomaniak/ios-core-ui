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

    let configuration: MyKSuiteConfiguration

    public init(configuration: MyKSuiteConfiguration) {
        self.configuration = configuration
    }

    public var body: some View {
        VStack(spacing: 32) {
            ImageHelper.gradient
                .resizable()
                .scaledToFit()

            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading, spacing: IKPadding.medium) {
                    Text("myKSuiteUpgradeTitle", bundle: .module)
                        .font(FontHelper.title)
                        .foregroundStyle(ColorHelper.primary)
                        .frame(maxWidth: .infinity, alignment: .center)

                    Text("myKSuiteUpgradeDescription", bundle: .module)
                }

                VStack(alignment: .leading, spacing: IKPadding.medium) {
                    ForEach(configuration.labels) { label in
                        Label {
                            Text(label.text)
                        } icon: {
                            label.icon
                        }
                    }
                }

                Text("myKSuiteUpgradeDetails", bundle: .module)

                Button {
                    dismiss()
                } label: {
                    Text("buttonClose", bundle: .module)
                }
                .ikButtonFullWidth(true)
                .controlSize(.large)
                .buttonStyle(.ikBorderedProminent)
            }
            .padding(.horizontal, value: .large)
            .font(FontHelper.body)
            .foregroundStyle(ColorHelper.secondary)
        }
    }
}

@available(iOS 15.0, *)
#Preview("kDrive") {
    MyKSuiteView(configuration: .kDrive)
}

@available(iOS 15.0, *)
#Preview("Mail") {
    MyKSuiteView(configuration: .mail)
}
