//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 22/01/2025.
//

import SwiftUI

@available(iOS 15, *)
struct SubscriptionCardView: View {
    let myKSuite: MyKSuite

    var body: some View {
        VStack(spacing: 24) {
            HeaderView(myKSuite: myKSuite)

            Divider()

            SubscriptionProductsView(myKSuite: myKSuite)

            Divider()

            if myKSuite.isFree {
                SubscriptionFreeDetailsView(dailyLimit: myKSuite.freeMail.dailyLimitSent)
            } else {
                SubscriptionPlusDetailsView()
            }
        }
        .padding(value: .medium)
        .background(.white)
        .cardStyle()
    }
}

@available(iOS 15, *)
#Preview {
    SubscriptionCardView(myKSuite: PreviewHelper.sampleMyKSuite)
        .padding()
}
