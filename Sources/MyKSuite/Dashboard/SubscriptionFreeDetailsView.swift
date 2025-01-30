//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 23/01/2025.
//

import SwiftUI

@available(iOS 15.0, *)
struct SubscriptionFreeDetailsView: View {
    let dailyLimit: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Label {
                Text("myKSuiteDashboardFreeMailLabel", bundle: .module)
            } icon: {
                Image(systemName: "envelope")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16)
                    .foregroundStyle(ColorHelper.elephant)
            }

            DisclosureGroup {
                VStack(alignment: .leading, spacing: 8) {
                    Text("myKSuiteDashboardFunctionalityMailAndDrive", bundle: .module)
                    HStack {
                        Text("myKSuiteDashboardFunctionalityLimit", bundle: .module)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("\(dailyLimit)")
                            .foregroundStyle(ColorHelper.orca)
                            .font(FontHelper.bodySmallMedium)
                    }
                    Text("myKSuiteDashboardFunctionalityCustomReminders", bundle: .module)
                }
                .padding(.top, 18)
                .foregroundStyle(ColorHelper.elephant)
                .font(FontHelper.bodySmall)
            } label: {
                Label {
                    Text("myKSuiteDashboardLimitedFunctionalityLabel", bundle: .module)
                } icon: {
                    ImageHelper.lock
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16)
                        .foregroundStyle(ColorHelper.elephant)
                }
            }
        }
        .font(FontHelper.body)
        .foregroundStyle(ColorHelper.orca)
    }
}

@available(iOS 15.0, *)
#Preview {
    SubscriptionFreeDetailsView(dailyLimit: 500)
}
