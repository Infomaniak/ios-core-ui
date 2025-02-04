//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 22/01/2025.
//

import SwiftUI

@available(iOS 15, *)
struct ProductProgressView: View {
    @Environment(\.colorScheme) private var colorScheme
    let product: Product
    let usedValue: Int64
    let totalValue: Int64

    var body: some View {
        VStack {
            HStack {
                Text(product.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(ColorHelper.primary)
                    .font(FontHelper.body)

                Text("\(usedValue.formatted(.defaultByteCount)) / \(totalValue.formatted(.defaultByteCount))")
                    .foregroundStyle(ColorHelper.secondary)
                    .font(FontHelper.bodySmall)
            }

            ProgressView(value: Double(usedValue), total: Double(totalValue))
                .progressViewStyle(CustomProgressBar())
                .foregroundStyle(product.color)
        }
    }
}

@available(iOS 15, *)
#Preview {
    ProductProgressView(product: .mail, usedValue: 2300, totalValue: 20)
}
