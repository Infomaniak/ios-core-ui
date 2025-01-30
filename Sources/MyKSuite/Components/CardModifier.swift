//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 23/01/2025.
//

import SwiftUI

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(.rect(cornerRadius: 16))
            .shadow(color: ColorHelper.shadow.opacity(0.3), radius: 10)
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardModifier())
    }
}
