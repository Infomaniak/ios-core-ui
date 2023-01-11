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

#if os(macOS)
    import AppKit
#elseif os(iOS)
    import UIKit
#elseif os(tvOS) || os(watchOS)
    import UIKit
#endif

import CloudKit
import SnackBar

class IKWrapperView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view != self {
            return view
        }
        return nil
    }
}

class IKRootViewController: UIViewController {
    override func loadView() {
        view = IKWrapperView()
    }
}

class IKWindow: UIWindow {
    init(with rootVC: UIViewController) {
        if let scene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            super.init(windowScene: scene)
        } else {
            super.init(frame: UIScreen.main.bounds)
        }
        backgroundColor = .clear
        rootViewController = rootVC
        accessibilityViewIsModal = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let rootViewController = IKWindowProvider.shared.rootViewController {
            return rootViewController.view.hitTest(point, with: event)
        }
        return nil
    }
}

public class IKWindowProvider {
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
        let newSnackBar = IKSnackBar(contextView: vc.view, message: message, duration: duration, style: style, elevation: elevation)
        entryWindow.isHidden = false
        self.snackBar = newSnackBar
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

public class IKSnackBar: SnackBar {
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
    }

    required init(contextView: UIView, message: String, duration: SnackBar.Duration, style: SnackBarStyle = SnackBarStyle()) {
        super.init(contextView: contextView, message: message, duration: duration, style: style)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public static func make(message: String, duration: Duration, style: SnackBarStyle = .infomaniakStyle, elevation: Double = 6) -> Self? {
        return IKWindowProvider.shared.displaySnackBar(message: message, duration: duration, style: style, elevation: elevation) as? Self
    }

    public func setAction(_ action: Action) -> SnackBarPresentable {
        return setAction(with: action.title, action: action.action)
    }

    deinit {
        IKWindowProvider.shared.displayRollbackWindowIfNeeded()
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
