//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 22/01/2025.
//

import SwiftUI

@available(iOS 15, *)
struct SubscriptionCardView: View {
    let type: SubscriptionType

    var body: some View {
        VStack(spacing: 24) {
            HeaderView(type: type)

            Divider()

            VStack(spacing: 16) {
                ProductProgressView(title: "Mail", color: .blue, usedValue: 1, totalValue: 20)
                ProductProgressView(title: "kDrive", color: .blue, usedValue: 2.3, totalValue: 15)
            }

            Divider()

            SubscriptionFreeDetailsView()
            SubscriptionPlusDetailsView()
        }
        .padding(value: .medium)
        .background(.white)
        .cardStyle()
    }
}

@available(iOS 15, *)
#Preview {
    SubscriptionCardView(type: .myKSuite)
        .padding()
}
