//
//  File.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 30/01/2025.
//

import Foundation

enum PreviewHelper {
    static let samplePack = Pack(
        id: 1,
        name: "my_ksuite",
        driveStorage: 15,
        mailStorage: 20,
        mailDailyLimitSend: 500,
        isMaxStorageOffer: false
    )

    static let sampleFreeMail = FreeMail(
        id: 343_334,
        dailyLimitSent: 500,
        storageSizeLimit: 20,
        email: "ksuitemombile@ik.me",
        usedSize: 27
    )

    static let sampleMyKSuite = MyKSuite(
        id: 81,
        status: "healthy",
        packId: 1,
        pack: samplePack,
        isFree: true,
        freeMail: sampleFreeMail,
        hasAutoRenew: false
    )
}
