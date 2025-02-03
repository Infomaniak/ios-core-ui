//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 03/02/2025.
//

import InfomaniakCoreSwiftUI
import SwiftUI

@available(iOS 15.0, *)
struct SubscriptionBenefitsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: IKPadding.large) {
            Text("myKSuiteUpgradeBenefitsTitle", bundle: .module)
                .foregroundStyle(ColorHelper.elephant)
                .font(FontHelper.bodySmall)

            Label {
                Text("myKSuiteUpgradeDriveLabel", bundle: .module)
            } icon: {
                Image("drive", bundle: .module)
                    .resizable()
                    .frame(width: 16, height: 16)
            }

            Label {
                Text("myKSuiteUpgradeUnlimitedMailLabel", bundle: .module)
            } icon: {
                Image("plane", bundle: .module)
                    .resizable()
                    .frame(width: 16, height: 16)
            }

            Label {
                Text("myKSuiteUpgradeLabel", bundle: .module)
            } icon: {
                Image("gift", bundle: .module)
                    .resizable()
                    .frame(width: 16, height: 16)
            }
        }
        .foregroundStyle(ColorHelper.primary)
        .font(FontHelper.body)
        .padding(value: .medium)
        .background(.white)
        .cardStyle()
    }
}

@available(iOS 15.0, *)
#Preview {
    SubscriptionBenefitsView()
        .padding()
}
