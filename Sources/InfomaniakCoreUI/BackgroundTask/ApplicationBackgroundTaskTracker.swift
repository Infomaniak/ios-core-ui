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

#if canImport(UIKit)

import Foundation
import UIKit

/// Something to generate and track an UIApplication.BackgroundTask in a modern Async/Await context.
public protocol ApplicationBackgroundTaskTrackable: AnyObject {
    /// Initialize a background task, from an identifier, with an optional async completion handler.
    init(identifier: String, expirationHandler: (() -> Void)?) async

    /// Terminate a background task
    func end() async
}

@available(iOSApplicationExtension, unavailable)
@available(*, deprecated, message: "Use BackgroundExecutor from the ios-core package instead")
public final class ApplicationBackgroundTaskTracker: ApplicationBackgroundTaskTrackable {
    /// A background task identifier
    private let identifier: String

    /// Callback to execute on a task expiration. Performed on MainActor.
    private var expirationHandler: (() async -> Void)?

    private var _state: UIBackgroundTaskIdentifier = .invalid
    public var state: UIBackgroundTaskIdentifier? {
        guard _state != .invalid else {
            return nil
        }

        return _state
    }

    public init(identifier: String, expirationHandler: (() -> Void)? = nil) async {
        self.identifier = identifier
        self.expirationHandler = expirationHandler
        await begin()
    }

    private func begin() async {
        _state = await UIApplication.shared.beginBackgroundTask(withName: identifier) {
            guard let currentState = self.state else {
                return
            }

            self._state = .invalid
            Task { @MainActor in
                await self.expirationHandler?()

                UIApplication.shared.endBackgroundTask(currentState)
            }
        }
    }

    public func end() async {
        guard let currentState = state else {
            return
        }

        _state = .invalid
        await UIApplication.shared.endBackgroundTask(currentState)
    }
}

#endif
