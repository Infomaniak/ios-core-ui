//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 28/01/2025.
//

import SwiftUI

@available(iOS 15.0, *)
struct HeaderView: View {
    let type: SubscriptionType

    var body: some View {
        HStack {
            Image(systemName: "person")
                .resizable()
                .clipShape(.circle)
                .padding(4)
                .background {
                    ColorHelper.gradient
                        .clipShape(.circle)
                }
                .frame(width: 24, height: 24)

            Text("ellen.ripley@ik.me")
                .frame(maxWidth: .infinity, alignment: .leading)

            type.icon
                .padding(.horizontal, value: .small)
                .padding(.vertical, value: .extraSmall)
                .background(ColorHelper.rabbit)
                .clipShape(Capsule())
        }
    }
}

@available(iOS 15.0, *)
#Preview {
    HeaderView(type: .myKSuite)
}
