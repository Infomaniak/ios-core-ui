//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 22/01/2025.
//

import InfomaniakCore
import InfomaniakCoreSwiftUI
import InfomaniakDI
import SwiftUI

@available(iOS 15, *)
public struct MyKSuiteDashboardView: View {
    @InjectService var myKSuiteStore: MyKSuiteStore
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
                    SubscriptionCardView(myKSuite: PreviewHelper.sampleMyKSuite /* myKSuite */ )

//                    if myKSuite.isFree {
//                        FreeTrialView()
//                    }
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
                .background {
                    ImageHelper.background
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, alignment: .top)
                }
            }
        }
        .task {
            do {
                myKSuite = try await myKSuiteStore.updateMyKSuite(with: apiFetcher)
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
