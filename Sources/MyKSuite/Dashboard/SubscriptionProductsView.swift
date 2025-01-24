//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 23/01/2025.
//

import SwiftUI

@available(iOS 15, *)
struct SubscriptionProductsView: View {
    let type: SubscriptionType
    
    var body: some View {
        VStack(spacing: 16) {
            ProductProgressView(title: "Mail", color: .blue, usedValue: 1, totalValue: 20)
            ProductProgressView(title: "kDrive", color: .blue, usedValue: 2.3, totalValue: 15)
        }
    }
}

@available(iOS 15, *)
#Preview {
    SubscriptionProductsView(type: .myKSuite)
}
