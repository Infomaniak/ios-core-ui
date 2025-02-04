//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 23/01/2025.
//

import SwiftUI

@available(iOS 15, *)
struct SubscriptionProductsView: View {
    let myKSuite: MyKSuite

    var body: some View {
        VStack(spacing: 16) {
            if myKSuite.isFree {
                ProductProgressView(
                    product: .mail,
                    usedValue: myKSuite.freeMail.usedSize,
                    totalValue: myKSuite.freeMail.storageSizeLimit
                )
            } else {
                HStack {
                    Text(Product.mail.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(ColorHelper.primary)
                        .font(FontHelper.body)

                    Text("myKSuiteDashboardDataUnlimited", bundle: .module)
                        .foregroundStyle(ColorHelper.secondary)
                        .font(FontHelper.bodySmall)
                }
            }

            ProductProgressView(product: .drive, usedValue: myKSuite.drive.usedSize, totalValue: myKSuite.drive.size)
        }
    }
}

@available(iOS 15, *)
#Preview {
    SubscriptionProductsView(myKSuite: PreviewHelper.sampleMyKSuite)
}
