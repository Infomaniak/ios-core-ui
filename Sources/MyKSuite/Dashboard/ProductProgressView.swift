//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 22/01/2025.
//

import SwiftUI

@available(iOS 15, *)
struct ProductProgressView: View {
    let product: Product
    let usedValue: Int?
    let totalValue: Int

    private var floatUsedValue: Float {
        guard let usedValue else {
            return 0
        }
        return Float(usedValue / 1000)
    }

    private var floatTotalValue: Float {
        Float(totalValue)
    }

    var body: some View {
        VStack {
            HStack {
                Text(product.title)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("\(floatUsedValue, specifier: "%.1f") Go / \(floatTotalValue, specifier: "%.0f") Go")
            }

            ProgressView(value: floatUsedValue, total: floatTotalValue)
                .progressViewStyle(CustomProgressBar())
                .foregroundStyle(product.color)
        }
    }
}

@available(iOS 15, *)
#Preview {
    ProductProgressView(product: .mail, usedValue: 2300, totalValue: 20)
}
