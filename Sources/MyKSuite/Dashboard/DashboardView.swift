//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 22/01/2025.
//

import SwiftUI
import InfomaniakCoreSwiftUI

@available(iOS 15, *)
struct DashboardView: View {
    var body: some View {
        SubscriptionCardView(type: .myKSuite)
            .padding(value: .medium)
    }
}

@available(iOS 15, *)
#Preview {
    DashboardView()
}
