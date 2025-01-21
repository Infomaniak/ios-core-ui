//
//  File.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 20/01/2025.
//

import SwiftUI

enum MykSuiteType {
    case kdrive
    case mail

    var labels: [(id: Int, icon: String, localizable: LocalizedStringKey)] {
        switch self {
        case .kdrive:
            return [
                (id: 0, icon: "drive", localizable: "kdriveLabel1"),
                (id: 1, icon: "folder.arrow.up", localizable: "kdriveLabel2"),
                (id: 2, icon: "gift", localizable: "label3"),
            ]
        case .mail:
            return [
                (id: 0, icon: "plane", localizable: "kmailLabel1"),
                (id: 1, icon: "envelope", localizable: "kmailLabel2"),
                (id: 2, icon: "gift", localizable: "label3"),
            ]
        }
    }
}
