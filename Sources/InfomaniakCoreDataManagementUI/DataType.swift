/*
 Infomaniak Mail - iOS App
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

public enum DataType: String, CaseIterable, Identifiable {
    case matomo
    case sentry

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .matomo:
            return "settingsMatomoTitle"
        case .sentry:
            return "settingsSentryTitle"
        }
    }

    public var description: String {
        switch self {
        case .matomo:
            return "settingsMatomoDescription"
        case .sentry:
            return "settingsSentryDescription"
        }
    }

    public var image: Image {
        switch self {
        case .matomo:
            return Image("matomo", bundle: .module)
        case .sentry:
            return Image("sentry", bundle: .module)
        }
    }

    public var matomoName: String {
        return rawValue
    }

    public var imageText: Image {
        switch self {
        case .matomo:
            return Image("matomo-text", bundle: .module)
        case .sentry:
            return Image("sentry-text", bundle: .module)
        }
    }
}
