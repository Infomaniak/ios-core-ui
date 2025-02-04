//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 23/01/2025.
//

import SwiftUI

@available(iOS 15.0, *)
struct CardModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    let withStroke: Bool

    private var strokeOpacity: Double {
        if withStroke {
            return colorScheme == .light ? 0 : 1
        }
        return 0
    }

    private var shadowOpacity: Double {
        colorScheme == .light ? 0.3 : 0
    }

    func body(content: Content) -> some View {
        content
            .clipShape(.rect(cornerRadius: 16))
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(ColorHelper.elephant.opacity(strokeOpacity), lineWidth: 1)
            }
            .shadow(color: ColorHelper.shark.opacity(shadowOpacity), radius: 10)
    }
}

@available(iOS 15.0, *)
extension View {
    func cardStyle(withStroke: Bool = true) -> some View {
        modifier(CardModifier(withStroke: withStroke))
    }
}
