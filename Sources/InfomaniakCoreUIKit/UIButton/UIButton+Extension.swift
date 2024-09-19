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

import UIKit

public extension UIButton {
    func setLoading(_ loading: Bool, style: UIActivityIndicatorView.Style = .medium) {
        isEnabled = !loading
        if loading {
            setTitle("", for: .disabled)
            let loadingSpinner = UIActivityIndicatorView(style: style)
            loadingSpinner.startAnimating()
            loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
            loadingSpinner.hidesWhenStopped = true
            addSubview(loadingSpinner)
            loadingSpinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            loadingSpinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        } else {
            setTitle(title(for: .normal), for: .disabled)
            for view in subviews {
                if view.isKind(of: UIActivityIndicatorView.self) {
                    view.removeFromSuperview()
                }
            }
        }
    }
}
