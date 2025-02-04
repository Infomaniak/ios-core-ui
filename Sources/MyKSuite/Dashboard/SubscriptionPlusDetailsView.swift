//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 27/01/2025.
//

import SwiftUI

@available(iOS 15.0, *)
struct SubscriptionPlusDetailsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Text("myKSuiteDashboardTrialPeriod", bundle: .module)
                    .foregroundStyle(ColorHelper.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(
                    String(
                        format: NSLocalizedString("myKSuiteDashboardUntil", bundle: .module, comment: ""),
                        arguments: ["xx/xx/xxxx"]
                    )
                )
                .foregroundStyle(ColorHelper.secondary)
            }

            // Waiting for InAppPurchase
            
//            HStack {
//                Text("myKSuiteDashboardPaymentMethod", bundle: .module)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .foregroundStyle(ColorHelper.primary)
//                Text("!Apple Pay")
//                    .foregroundStyle(ColorHelper.secondary)
//            }


            HStack(alignment: .top, spacing: 12) {
                ImageHelper.information
                    .foregroundStyle(ColorHelper.secondary)

                VStack(alignment: .leading, spacing: 16) {
                    Text("myKSuiteManageSubscriptionDescription", bundle: .module)
                        .foregroundStyle(ColorHelper.primary)

                    Button {
                        // Gerer mon abonnement
                    } label: {
                        Text("myKSuiteManageSubscriptionButton", bundle: .module)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(value: .medium)
            .background(ColorHelper.backgroundSecondary, in: .rect(cornerRadius: 8))
        }
    }
}

@available(iOS 15.0, *)
#Preview {
    SubscriptionPlusDetailsView()
}
