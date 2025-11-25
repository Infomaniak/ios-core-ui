//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.

#if canImport(UIKit)
import UIKit

public extension UIColor {
    static let avatarColors = [
        UIColor.InfomaniakColors.yellow,
        UIColor.InfomaniakColors.coral,
        UIColor.InfomaniakColors.grass,
        UIColor.InfomaniakColors.fougere,
        UIColor.InfomaniakColors.cobalt,
        UIColor.InfomaniakColors.jean,
        UIColor.InfomaniakColors.tropical,
        UIColor.InfomaniakColors.mauve,
        UIColor.InfomaniakColors.prince
    ]

    class func backgroundColor(from hash: Int, with colors: [UIColor] = UIColor.avatarColors) -> UIColor {
        let colorIndex = abs(hash % colors.count)
        return colors[colorIndex]
    }
}
#endif

import SwiftUI

public extension Color {
    static let avatarColors = [
        Color.InfomaniakColors.yellow,
        Color.InfomaniakColors.coral,
        Color.InfomaniakColors.grass,
        Color.InfomaniakColors.fougere,
        Color.InfomaniakColors.cobalt,
        Color.InfomaniakColors.jean,
        Color.InfomaniakColors.tropical,
        Color.InfomaniakColors.mauve,
        Color.InfomaniakColors.prince
    ]

    static func backgroundColor(from hash: Int, with colors: [Color] = Color.avatarColors) -> Color {
        let colorIndex = abs(hash % colors.count)
        return colors[colorIndex]
    }
}
