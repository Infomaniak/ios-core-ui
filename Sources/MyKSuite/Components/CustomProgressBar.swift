//
//  CustomProgressBar.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 22/01/2025.
//

import SwiftUI

@available(iOS 15, *)
struct CustomProgressBar: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 14)
                .foregroundStyle(ColorHelper.rabbit)
                .overlay {
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: geometry.size.width * CGFloat(configuration.fractionCompleted ?? 0.0), height: 14)
                    }
                }
        }
    }
}

@available(iOS 15, *)
#Preview {
    ProgressView(value: 2.3, total: 15)
        .progressViewStyle(CustomProgressBar())
        .foregroundStyle(.blue)
}
