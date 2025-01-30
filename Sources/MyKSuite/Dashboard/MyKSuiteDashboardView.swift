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
public struct MyKSuiteDashboardView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var myKSuite: MyKSuite?
    let apiFetcher: ApiFetcher

    public init(apiFetcher: ApiFetcher) {
        self.apiFetcher = apiFetcher
    }

    public var body: some View {
        NavigationView {
            if let myKSuite {
                VStack(spacing: 24) {
                    SubscriptionCardView(myKSuite: myKSuite)

                    if myKSuite.isFree {
                        FreeTrialView()
                    }
                }
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
        }
        .task {
            do {
                myKSuite = try await apiFetcher.myKSuite(id: 81)
            } catch {
                print("error fetching my ksuite: \(error)")
            }
        }
    }
}

// @available(iOS 15, *)
// #Preview {
//    MyKSuiteDashboardView(apiFetcher: ApiFetcher())
// }
