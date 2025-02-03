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
    let usedValue: Int
    let totalValue: Int

    private var test: String {
        Int64(totalValue).formatted(.defaultByteCount)
    }

    var body: some View {
        VStack {
            HStack {
                Text(product.title)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("\(usedValue.formatted(.defaultByteCount)) / \(totalValue.formatted(.defaultByteCount))")
            }

            ProgressView(value: Float(usedValue), total: Float(totalValue))
                .progressViewStyle(CustomProgressBar())
                .foregroundStyle(product.color)
        }
    }
}

@available(iOS 15, *)
#Preview {
    ProductProgressView(product: .mail, usedValue: 2300, totalValue: 20)
}
