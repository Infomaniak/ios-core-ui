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
                    .foregroundStyle(Color("orca", bundle: .module))
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(
                    String(
                        format: NSLocalizedString("myKSuiteDashboardUntil", bundle: .module, comment: ""),
                        arguments: ["xx/xx/xxxx"]
                    )
                )
                .foregroundStyle(Color("elephant", bundle: .module))
            }

            HStack {
                Text("myKSuiteDashboardPaymentMethod", bundle: .module)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color("orca", bundle: .module))
                Text("!Apple Pay")
                    .foregroundStyle(Color("elephant", bundle: .module))
            }

            HStack(alignment: .top, spacing: 12) {
                Image("information", bundle: .module)
                    .foregroundStyle(Color("elephant", bundle: .module))

                VStack(alignment: .leading, spacing: 16) {
                    Text("myKSuiteDashboardSubscriptionLabel", bundle: .module)
                        .foregroundStyle(Color("orca", bundle: .module))

                    Button {
                        // Gerer mon abonnement
                    } label: {
                        Text("myKSuiteDashboardSubscriptionButton", bundle: .module)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(value: .medium)
            .background(Color("polar.bear", bundle: .module), in: .rect(cornerRadius: 8))
        }
    }
}

@available(iOS 15.0, *)
#Preview {
    SubscriptionPlusDetailsView()
}
