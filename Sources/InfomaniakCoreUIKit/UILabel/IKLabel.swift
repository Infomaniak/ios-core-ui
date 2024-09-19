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

import InfomaniakCoreCommonUI

@IBDesignable public class IKLabel: UILabel {
    /// Set label style.
    @IBInspectable public var styleName: String = TextStyle.body1.rawValue {
        didSet { setUpLabel() }
    }

    /// Set label style.
    public var style: TextStyle {
        get {
            return TextStyle(rawValue: styleName) ?? .body1
        }
        set {
            styleName = newValue.rawValue
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setUpLabel()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpLabel()
    }

    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpLabel()
    }

    func setUpLabel() {
        font = style.font
        textColor = style.color
    }
}
