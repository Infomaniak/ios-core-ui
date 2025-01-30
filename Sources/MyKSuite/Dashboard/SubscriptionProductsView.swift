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

                    Text("!Illimité")
                }
            }

            ProductProgressView(product: .drive, usedValue: 23, totalValue: 15)
        }
    }
}

@available(iOS 15, *)
#Preview {
    SubscriptionProductsView(myKSuite: PreviewHelper.sampleMyKSuite)
}
