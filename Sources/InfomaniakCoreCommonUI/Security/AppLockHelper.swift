/*
 Infomaniak Core - iOS
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

import LocalAuthentication
import UIKit

public final class AppLockHelper {
    public static let lockAfterOneMinute: TimeInterval = 60

    private var deviceHasBeenLocked = false
    private let intervalToLockApp: TimeInterval
    private var timeSinceAppEnteredBackground = TimeInterval.zero

    public var isAppLocked: Bool {
        let timeHasExpired = timeSinceAppEnteredBackground + intervalToLockApp < Date().timeIntervalSince1970
        return isAvailable() && (timeHasExpired || deviceHasBeenLocked)
    }

    public init(intervalToLockApp: TimeInterval = AppLockHelper.lockAfterOneMinute) {
        self.intervalToLockApp = intervalToLockApp
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(deviceDidLock),
                                               name: UIApplication.protectedDataWillBecomeUnavailableNotification,
                                               object: nil)
    }

    public func isAvailable(_ context: LAContext? = nil) -> Bool {
        let currentContext = context ?? LAContext()
        return currentContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
    }

    public func setTime() {
        timeSinceAppEnteredBackground = Date().timeIntervalSince1970
        deviceHasBeenLocked = false
    }

    public func evaluatePolicy(reason: String) async throws -> Bool {
        let context = LAContext()
        guard isAvailable(context) else {
            return false
        }

        return try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason)
    }

    @objc private func deviceDidLock() {
        deviceHasBeenLocked = true
    }
}
