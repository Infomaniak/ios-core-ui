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

public final class IKWindowProvider {
    public static let shared = IKWindowProvider()

    var entryWindow: IKWindow!

    var rootViewController: UIViewController? {
        return entryWindow?.rootViewController
    }

    private weak var snackBar: IKSnackBar?

    private weak var mainRollbackWindow: UIWindow?

    private init() {
        // Empty to use as singleton
    }

    func setupWindowAndRootVC() -> UIViewController {
        let entryViewController: UIViewController
        if entryWindow == nil {
            entryViewController = IKRootViewController()
            entryWindow = IKWindow(with: entryViewController)
            entryWindow.isHidden = false
            mainRollbackWindow = UIApplication.shared.keyWindow
            // Adjust insets based on presented view controller under
            if let topViewInsets = mainRollbackWindow?.rootViewController?.displayedViewController.view.safeAreaInsets {
                let safeAreaInsets = entryViewController.view.safeAreaInsets
                let insets = UIEdgeInsets(
                    top: topViewInsets.top - safeAreaInsets.top,
                    left: topViewInsets.left - safeAreaInsets.left,
                    bottom: topViewInsets.bottom - safeAreaInsets.bottom,
                    right: topViewInsets.right - safeAreaInsets.right
                )
                entryViewController.additionalSafeAreaInsets = insets
            }
        } else {
            entryViewController = rootViewController!
        }
        return entryViewController
    }

    func displaySnackBar(message: String, duration: IKSnackBar.Duration, style: SnackBarStyle, elevation: Double) -> IKSnackBar {
        // Remove old snackbar
        snackBar?.dismiss()
        // Create new snackbar
        let vc = setupWindowAndRootVC()
        let newSnackBar = IKSnackBar(
            contextView: vc.view,
            message: message,
            duration: duration,
            style: style,
            elevation: elevation
        )
        entryWindow.isHidden = false
        snackBar = newSnackBar
        return newSnackBar
    }

    func displayRollbackWindowIfNeeded() {
        if snackBar == nil {
            displayRollbackWindow()
        }
    }

    private func displayRollbackWindow() {
        entryWindow?.windowScene = nil
        entryWindow = nil
        if let mainRollbackWindow = mainRollbackWindow {
            mainRollbackWindow.makeKeyAndVisible()
        } else {
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
        }
    }
}

#endif
