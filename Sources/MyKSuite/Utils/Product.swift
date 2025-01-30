//
//  Product.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 30/01/2025.
//

import SwiftUI

enum Product {
    case mail
    case drive

    var title: String {
        switch self {
        case .mail:
            return "Mail"
        case .drive:
            return "kDrive"
        }
    }

    var color: Color {
        switch self {
        case .mail:
            return ColorHelper.productMail
        case .drive:
            return ColorHelper.productDrive
        }
    }
}
