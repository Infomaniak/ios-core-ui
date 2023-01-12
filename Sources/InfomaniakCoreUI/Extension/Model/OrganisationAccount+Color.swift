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

import InfomaniakCore
import UIKit

public extension InfomaniakCore.OrganisationAccount {
    var backgroundColor: UIColor {
        let nameAscii: [Int32] = name.replacingOccurrences(of: "/[^a-zA-Z ]+/", with: "", options: [.regularExpression]).compactMap { $0.asciiValue }.compactMap { Int32($0) }
        let hashCode: Int32 = nameAscii.reduce(0) { a, b in
            ((a &<< Int32(5)) &- a) &+ Int32(b)
        }
        let colorIndex = (abs(Int(hashCode)) &+ id) % 8
        return UIColor(named: "organisationColor\(colorIndex)")!
    }
}
