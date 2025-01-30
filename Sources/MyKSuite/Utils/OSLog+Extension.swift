//
//  File.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 30/01/2025.
//

import OSLog

@available(iOS 14.0, *)
public extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier ?? "com.infomaniak.myKSuite"

    static let general = Logger(subsystem: subsystem, category: "general")
}
