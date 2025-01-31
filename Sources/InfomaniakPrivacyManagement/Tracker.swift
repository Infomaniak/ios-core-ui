/*
 Infomaniak Core UI - iOS
 Copyright (C) 2025 Infomaniak Network SA

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import SwiftUI

public enum Tracker: String, CaseIterable, Identifiable {
    case matomo
    case sentry

    public var id: String { rawValue }

    public var title: LocalizedStringKey {
        switch self {
        case .matomo:
            return "trackingMatomoTitle"
        case .sentry:
            return "trackingSentryTitle"
        }
    }

    public var description: String {
        switch self {
        case .matomo:
            return "trackingMatomoDescription"
        case .sentry:
            return "trackingSentryDescription"
        }
    }

    public var logoShort: Image {
        switch self {
        case .matomo:
            return Image("matomo-short", bundle: .module)
        case .sentry:
            return Image("sentry-short", bundle: .module)
        }
    }

    public var logoLong: Image {
        switch self {
        case .matomo:
            return Image("matomo-long", bundle: .module)
        case .sentry:
            return Image("sentry-long", bundle: .module)
        }
    }
}
