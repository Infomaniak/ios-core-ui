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
import MatomoTracker
import OSLog

public extension os.Logger {
    static let matomo = Logger(subsystem: "InfomaniakCoreUI", category: "matomoUtils")
}

public final class MatomoUtils {
    private let tracker: MatomoTracker
    private let shouldLog: Bool

    public init(siteId: String, baseURL: URL, shouldLog: Bool = false) {
        tracker = MatomoTracker(siteId: siteId, baseURL: baseURL)

        #if DEBUG || TEST
        self.shouldLog = shouldLog
        #else
        self.shouldLog = false
        #endif
    }

    public func connectUser(userId: String) {
        tracker.userId = userId
    }

    public func optOut(_ optOut: Bool) {
        tracker.isOptedOut = optOut
    }

    public func track(view: [String]) {
        if shouldLog {
            Logger.matomo.debug("Matomo - View  : \(view)")
        }
        tracker.track(view: view)
    }

    public func track(eventWithCategory category: EventCategory, action: UserAction = .click, name: String, value: Float? = nil) {
        if shouldLog {
            logTrack(category: category, action: action, name: name, value: value)
        }
        tracker.track(eventWithCategory: category.displayName, action: action.rawValue, name: name, value: value)
    }

    public func track(eventWithCategory category: EventCategory, action: UserAction = .click, name: String, value: Bool) {
        track(eventWithCategory: category, action: action, name: name, value: value ? 1 : 0)
    }

    public func trackBulkEvent(eventWithCategory category: EventCategory, name: String, numberOfItems number: Int) {
        track(
            eventWithCategory: category,
            action: .click,
            name: "bulk\(number <= 1 ? "Single" : "")\(name)",
            value: Float(number)
        )
    }

    private func logTrack(category: EventCategory, action: UserAction, name: String, value: Any?) {
        var valueDescription: String?

        if let boolValue = value as? Bool {
            valueDescription = boolValue ? "1" : "0"
        } else if let intValue = value as? Int {
            valueDescription = "\(intValue)"
        } else if let floatValue = value as? Float {
            valueDescription = "\(floatValue)"
        }

        if let valueDesc = valueDescription {
            Logger.matomo.debug(
                "Matomo Event - Category: \(category.displayName), Name: \(name), Value: \(valueDesc), (Action: \(action.rawValue))"
            )
        } else {
            Logger.matomo.debug("Matomo Event - Category: \(category.displayName), Name: \(name), (Action: \(action.rawValue))")
        }
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
