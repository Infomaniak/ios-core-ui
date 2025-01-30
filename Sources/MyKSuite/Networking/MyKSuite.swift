//
//  File.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 30/01/2025.
//

import Foundation

struct MyKSuite: Decodable {
    let id: Int
    let status: String
    let packId: Int
    let pack: Pack
    let isFree: Bool
//    let drive: Drive
    let freeMail: FreeMail
    let hasAutoRenew: Bool
}

struct Pack: Decodable {
    let id: Int
    let name: String
    let driveStorage: Int
    let mailStorage: Int
    let mailDailyLimitSend: Int
    let isMaxStorageOffer: Bool
}

// struct Drive: Decodable {
//
// }

struct FreeMail: Decodable {
    let id: Int
    let dailyLimitSent: Int
    let storageSizeLimit: Int
    let email: String
    let usedSize: Int?
}
