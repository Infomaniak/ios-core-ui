//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 22/01/2025.
//

import SwiftUI

@available(iOS 15, *)
struct ProductProgressView: View {
    let title: String
    let color: Color
    let usedValue: Float
    let totalValue: Float

    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("\(usedValue, specifier: "%.1f") Go / \(totalValue, specifier: "%.0f") Go")
            }

            ProgressView(value: usedValue, total: totalValue)
                .progressViewStyle(CustomProgressBar())
                .foregroundStyle(color)
        }
    }
}

@available(iOS 15, *)
#Preview {
    ProductProgressView(title: "Mail", color: .blue, usedValue: 2.3, totalValue: 20)
}
