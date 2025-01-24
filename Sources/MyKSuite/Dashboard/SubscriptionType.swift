//
//  File.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 23/01/2025.
//

import SwiftUI

enum SubscriptionType {
    case myKSuite
    case myKSuitePlus

    var icon: Image {
        switch self {
        case .myKSuite:
            return .init("myKSuite.logo", bundle: .module)
        case .myKSuitePlus:
            return .init("myKSuitePlus.logo", bundle: .module)
        }
    }
}
