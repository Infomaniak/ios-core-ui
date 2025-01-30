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
                    .foregroundStyle(ColorHelper.orca)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(
                    String(
                        format: NSLocalizedString("myKSuiteDashboardUntil", bundle: .module, comment: ""),
                        arguments: ["xx/xx/xxxx"]
                    )
                )
                .foregroundStyle(ColorHelper.elephant)
            }

            HStack {
                Text("myKSuiteDashboardPaymentMethod", bundle: .module)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(ColorHelper.orca)
                Text("!Apple Pay")
                    .foregroundStyle(ColorHelper.elephant)
            }

            HStack(alignment: .top, spacing: 12) {
                ImageHelper.information
                    .foregroundStyle(ColorHelper.elephant)

                VStack(alignment: .leading, spacing: 16) {
                    Text("myKSuiteDashboardSubscriptionLabel", bundle: .module)
                        .foregroundStyle(ColorHelper.orca)

                    Button {
                        // Gerer mon abonnement
                    } label: {
                        Text("myKSuiteDashboardSubscriptionButton", bundle: .module)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(value: .medium)
            .background(ColorHelper.polarBear, in: .rect(cornerRadius: 8))
        }
    }
}

@available(iOS 15.0, *)
#Preview {
    SubscriptionPlusDetailsView()
}
