//
//  File.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 30/01/2025.
//

import SwiftUI

public struct MyKSuite: Codable {
    let id: Int
    let status: String
    let packId: Int
    let pack: Pack
    let isFree: Bool
//    let drive: Drive
    let freeMail: FreeMail
    let hasAutoRenew: Bool

    var icon: Image {
        if isFree {
            return ImageHelper.myKSuiteLogo
        }
        return ImageHelper.myKSuitePlusLogo
    }
}

struct Pack: Codable {
    let id: Int
    let name: String
    let driveStorage: Int
    let mailStorage: Int
    let mailDailyLimitSend: Int
    let isMaxStorageOffer: Bool
}

// struct Drive: Codable {
//
// }

struct FreeMail: Codable {
    let id: Int
    let dailyLimitSent: Int
    let storageSizeLimit: Int
    let email: String
    let usedSize: Int?
}
