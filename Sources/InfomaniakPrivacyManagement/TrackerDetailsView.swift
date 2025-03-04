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
import InfomaniakCoreSwiftUI
import InfomaniakDI
import SwiftUI

@available(iOS 15.0, *)
struct TrackerDetailsView: View {
    @Environment(\.dismiss) private var dismiss

    @AppStorage private var dataValue: Bool

    private let backgroundColor: Color
    private let tracker: Tracker

    init(tracker: Tracker, appStorageKey: String, backgroundColor: Color) {
        self.tracker = tracker
        _dataValue = AppStorage(wrappedValue: true, appStorageKey)
        self.backgroundColor = backgroundColor
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    tracker.logoLong
                        .padding(.vertical, value: .medium)
                        .frame(maxWidth: .infinity)

                    Text(LocalizedStringKey(tracker.description), bundle: .module)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .padding(IKPadding.medium)

                    Toggle(isOn: $dataValue) {
                        Text("authorizeTracking", bundle: .module)
                            .font(.body)
                    }
                    .tint(.accentColor)
                    .padding(value: .medium)
                }
            }
            .background(backgroundColor)
            .navigationBarTitle(Text(tracker.title, bundle: .module), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
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
#Preview {
    TrackerDetailsView(
        tracker: Tracker.matomo,
        appStorageKey: "matomoKey",
        backgroundColor: .white
    )
}
