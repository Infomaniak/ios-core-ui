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

import CloudKit
import SnackBar
import UIKit

extension UIViewController {
    var displayedViewController: UIViewController {
        if let controller = self as? UINavigationController, let visibleViewController = controller.visibleViewController {
            return visibleViewController.displayedViewController
        } else if let controller = self as? UISplitViewController, let lastViewController = controller.viewControllers.last {
            return lastViewController.displayedViewController
        } else if let controller = self as? UITabBarController, let selectedViewController = controller.selectedViewController {
            return selectedViewController.displayedViewController
        } else if let controller = presentedViewController {
            return controller.displayedViewController
        } else {
            return self
        }
    }
}

public final class IKSnackBar: SnackBar {
    public static let dismissSnackbarNotificationName = Notification.Name(rawValue: "dismissSnackbar")
    
    public struct Action {
        let title: String
        let action: () -> Void

        public init(title: String, action: @escaping () -> Void) {
            self.title = title
            self.action = action
        }
    }

    required init(contextView: UIView, message: String, duration: Duration, style: SnackBarStyle, elevation: Double) {
        super.init(contextView: contextView, message: message, duration: duration, style: style)
        addShadow(elevation: elevation)
        self.commonInit()
    }

    required init(contextView: UIView, message: String, duration: SnackBar.Duration, style: SnackBarStyle = SnackBarStyle()) {
        super.init(contextView: contextView, message: message, duration: duration, style: style)
        self.commonInit()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public static func make(message: String, duration: Duration, style: SnackBarStyle = .infomaniakStyle,
                            elevation: Double = 6) -> Self? {
        return IKWindowProvider.shared.displaySnackBar(
            message: message,
            duration: duration,
            style: style,
            elevation: elevation
        ) as? Self
    }

    public func setAction(_ action: Action) -> SnackBarPresentable {
        return setAction(with: action.title, action: action.action)
    }
    
    func commonInit() {
        NotificationCenter.default.addObserver(
                            self,
                            selector: #selector(shouldDismiss),
                            name: Self.dismissSnackbarNotificationName,
                            object: nil
                        )
    }

    deinit {
        IKWindowProvider.shared.displayRollbackWindowIfNeeded()
        NotificationCenter.default.removeObserver(self, name: Self.dismissSnackbarNotificationName, object: nil)
    }
    
    @objc func shouldDismiss(_ notification: Notification) {
        dismiss()
    }
}

public extension SnackBarStyle {
    static var infomaniakStyle: SnackBarStyle {
        let textStyle = TextStyle.subtitle2
        let buttonStyle = TextStyle.action
        var snackBarStyle = SnackBarStyle()
        snackBarStyle.padding = 24
        snackBarStyle.background = InfomaniakCoreAsset.backgroundCardView.color
        snackBarStyle.textColor = textStyle.color
        snackBarStyle.font = textStyle.font
        snackBarStyle.actionTextColor = buttonStyle.color
        snackBarStyle.actionTextColorAlpha = 1
        snackBarStyle.actionFont = buttonStyle.font
        return snackBarStyle
    }
}

#endif
