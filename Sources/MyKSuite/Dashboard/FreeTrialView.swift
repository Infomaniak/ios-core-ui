//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 30/01/2025.
//

import SwiftUI

@available(iOS 15.0, *)
struct FreeTrialView: View {
    private let skyBackground = Color(light: ColorHelper.sky, dark: ColorHelper.bat)
    private let chipColor = Color(light: .white, dark: ColorHelper.orca)

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
                    .foregroundStyle(ColorHelper.primary)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .background(chipColor, in: .capsule)
            }
            Text("myKSuiteDashboardFreeTrialDescription", bundle: .module)
                .font(FontHelper.bodySmall)
                .foregroundStyle(ColorHelper.primary)

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
        .background(skyBackground, in: .rect(cornerRadius: 16))
        .cardStyle(withStroke: false)
    }
}

@available(iOS 15.0, *)
#Preview {
    FreeTrialView()
}
