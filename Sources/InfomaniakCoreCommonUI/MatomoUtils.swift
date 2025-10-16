/*
 Infomaniak Core UI - iOS
 Copyright (C) 2023 Infomaniak Network SA

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import Foundation
import InfomaniakDI
import MatomoTracker
import OSLog
import SwiftUI

public final class MatomoUtils {
    private let tracker: MatomoTracker
    private let enableLogger: Bool

    public init(siteId: String, baseURL: URL, enableLogger: Bool = false) {
        tracker = MatomoTracker(siteId: siteId, baseURL: baseURL)

        #if DEBUG || TEST
        self.enableLogger = enableLogger
        #else
        self.enableLogger = false
        #endif
    }

    public func connectUser(userId: String) {
        tracker.userId = userId
    }

    public func optOut(_ optOut: Bool) {
        tracker.isOptedOut = optOut
    }

    public func track(view: [String]) {
        if enableLogger {
            Logger.matomo.trackedView(view)
        }
        tracker.track(view: view)
    }

    public func track(eventWithCategory category: String, action: UserAction = .click, name: String, value: Float? = nil) {
        if enableLogger {
            Logger.matomo.trackedEvent(category: category, action: action, name: name, value: value)
        }
        tracker.track(eventWithCategory: category, action: action.rawValue, name: name, value: value)
    }

    public func track(eventWithCategory category: EventCategory, action: UserAction = .click, name: String, value: Float? = nil) {
        track(eventWithCategory: category.displayName, action: action, name: name, value: value)
    }

    public func track(eventWithCategory category: EventCategory, action: UserAction = .click, name: String, value: Bool) {
        track(eventWithCategory: category, action: action, name: name, value: value ? 1 : 0)
    }

    public func trackBulkEvent(eventWithCategory category: EventCategory, name: String, numberOfItems number: Int) {
        let uppercasedName = name.prefix(1).uppercased() + name.dropFirst()
        track(
            eventWithCategory: category,
            action: .click,
            name: "bulk\(number <= 1 ? "Single" : "")\(uppercasedName)",
            value: Float(number)
        )
    }
}

public extension MatomoUtils {
    class View {
        public let displayName: String

        public init(displayName: String) {
            self.displayName = displayName
        }
    }

    class EventCategory {
        public let displayName: String

        public init(displayName: String) {
            self.displayName = displayName
        }

        public static let account = EventCategory(displayName: "account")
        public static let appUpdate = EventCategory(displayName: "appUpdate")
        public static let appReview = EventCategory(displayName: "appReview")
    }

    enum UserAction: String {
        case click, input, drag, longPress, data
    }
}

extension os.Logger {
    static let matomo = Logger(subsystem: "InfomaniakCoreCommonUI", category: "matomoUtils")

    func trackedEvent(category: String, action: MatomoUtils.UserAction, name: String, value: Float?) {
        var logMessage = "category: \(category), name: \(name)"
        if let value {
            logMessage += ", value: \(value)"
        }
        logMessage += " (action: \(action.rawValue))"

        matomo(type: "Event", content: logMessage)
    }

    func trackedView(_ view: [String]) {
        matomo(type: "View", content: "\(view)")
    }

    private func matomo(type: String, content: String) {
        debug("[Matomo - \(type)] \(content)")
    }
}

public struct MatomoView: ViewModifier {
    @LazyInjectService private var matomo: MatomoUtils

    private let view: [String]

    public init(view: [String]) {
        self.view = view
    }

    public func body(content: Content) -> some View {
        content
            .onAppear {
                matomo.track(view: view)
            }
    }
}

public extension View {
    func matomoView(view: [String]) -> some View {
        modifier(MatomoView(view: view))
    }
}
