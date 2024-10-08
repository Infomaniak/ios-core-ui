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

public extension UIColor {
    static let organisationColors: [UIColor] = Array(0 ... 9)
        .map { UIColor(named: "organisationColor\($0)", in: Bundle.module, compatibleWith: nil) }
        .compactMap { $0 }

    class func backgroundColor(from userId: Int, with colors: [UIColor] = UIColor.organisationColors) -> UIColor {
        let colorIndex = abs(userId % colors.count)
        return colors[colorIndex]
    }
}
