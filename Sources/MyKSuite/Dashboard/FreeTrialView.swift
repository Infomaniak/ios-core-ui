//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 30/01/2025.
//

import SwiftUI

@available(iOS 15.0, *)
struct FreeTrialView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                ImageHelper.myKSuitePlusLogo
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90)

                Spacer()

                Text("myKSuiteDashboardFreeTrialTitle", bundle: .module)
                    .font(FontHelper.labelMedium)
                    .foregroundStyle(ColorHelper.orca)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .background(.white, in: .capsule)
            }
            Text("myKSuiteDashboardFreeTrialDescription", bundle: .module)
                .font(FontHelper.bodySmall)
                .foregroundStyle(ColorHelper.orca)

            Button {
                // Start trial
            } label: {
                Text("myKSuiteDashboardFreeTrialButton", bundle: .module)
            }
            .controlSize(.large)
            .ikButtonFullWidth(true)
            .buttonStyle(.ikBorderedProminent)
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(ColorHelper.gradient, lineWidth: 1)
        }
        .background(ColorHelper.sky, in: .rect(cornerRadius: 16))
        .cardStyle()
    }
}

@available(iOS 15.0, *)
#Preview {
    FreeTrialView()
}
