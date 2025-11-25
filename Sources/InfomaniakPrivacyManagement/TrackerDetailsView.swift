//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.

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
