//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 28/01/2025.
//

import SwiftUI

@available(iOS 15.0, *)
struct HeaderView: View {
    let myKSuite: MyKSuite

    var body: some View {
        HStack {
            ImageHelper.person
                .resizable()
                .scaledToFit()
                .frame(width: 14)
                .foregroundStyle(ColorHelper.elephant)
                .background {
                    Circle()
                        .strokeBorder(ColorHelper.gradient, lineWidth: 1)
                        .frame(width: 24, height: 24)
                }
                .frame(width: 24, height: 24)
                .background(ColorHelper.polarBear)
                .clipShape(.circle)

            Text(myKSuite.freeMail.email)
                .frame(maxWidth: .infinity, alignment: .leading)

            myKSuite.icon
                .padding(.horizontal, value: .small)
                .padding(.vertical, value: .extraSmall)
                .background(ColorHelper.rabbit)
                .clipShape(Capsule())
        }
    }
}

@available(iOS 15.0, *)
#Preview {
    HeaderView(myKSuite: PreviewHelper.sampleMyKSuite)
}
