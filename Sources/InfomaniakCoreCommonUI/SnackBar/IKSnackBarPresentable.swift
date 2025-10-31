/*
 Infomaniak Mail - iOS App
 Copyright (C) 2022 Infomaniak Network SA

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

import SnackBar
import UIKit

public protocol IKSnackBarPresentable {
    /// Show a `SnackBar` is current context
    func show(message: String)

    /// Show a `SnackBar`, with an action, is current context
    func show(message: String, action: IKSnackBar.Action?)

    /// Show a `SnackBar`, with maximum flexibility
    /// - Parameters:
    ///   - message: the message to be displayed
    ///   - duration: The duration the message should be displayed
    ///   - action: The optional action that should be displayed
    ///   - contextView: pass a context view in which the `SnackBar` should be displayed. Useful in complex situation.
    func show(
        message: String,
        duration: SnackBar.Duration,
        action: IKSnackBar.Action?,
        contextView: UIView?
    )
}
#endif
