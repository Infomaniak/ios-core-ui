//
//  File.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 28/01/2025.
//

import SwiftUI

enum ColorHelper {
    static let orca = Color("orca", bundle: .module)
    static let elephant = Color("elephant", bundle: .module)
    static let polarBear = Color("polar.bear", bundle: .module)
    static let rabbit = Color("rabbit", bundle: .module)
    static let shadow = Color("shadow", bundle: .module)

    // MARK: - Gradient

    static let gradientColor1 = Color("gradient.color.1", bundle: .module)
    static let gradientColor2 = Color("gradient.color.2", bundle: .module)
    static let gradientColor3 = Color("gradient.color.3", bundle: .module)
    static let gradientColor4 = Color("gradient.color.4", bundle: .module)
    static let gradientColor5 = Color("gradient.color.5", bundle: .module)

    static let gradient = LinearGradient(
        colors: [gradientColor1, gradientColor2, gradientColor3, gradientColor4, gradientColor5],
        startPoint: .leading,
        endPoint: .trailing
    )
}
