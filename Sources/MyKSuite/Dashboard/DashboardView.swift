//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 22/01/2025.
//

import InfomaniakCore
import InfomaniakCoreSwiftUI
import SwiftUI

@available(iOS 15, *)
public struct DashboardView: View {
    @Environment(\.dismiss) private var dismiss

    let apiFetcher: ApiFetcher

    public init(apiFetcher: ApiFetcher) {
        self.apiFetcher = apiFetcher
    }

    public var body: some View {
        NavigationView {
            SubscriptionCardView(type: .myKSuite)
                .padding(value: .medium)
                .navigationTitle(Text("myKSuiteDashboardTitle", bundle: .module))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(role: .destructive) {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .task {
            do {
                let myKSuite = try await apiFetcher.myKSuite(id: 81)
                print("myKSuite: \(myKSuite)")
            } catch {
                print("error fetching my ksuite: \(error)")
            }
        }
    }
}

@available(iOS 15, *)
#Preview {
    DashboardView(apiFetcher: ApiFetcher())
}
