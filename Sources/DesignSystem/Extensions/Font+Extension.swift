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

import SwiftUI

public extension Font {
    /// Create a custom font with the UIFont preferred font family.
    /// - Parameters:
    ///   - size: Default size of the font for the "large" `Dynamic Type Size`.
    ///   - weight: Weight of the font.
    ///   - textStyle: The text style on which the font will be based to scale.
    ///
    /// - Returns: A font with the specified attributes.
    ///
    /// SwiftUI will use the default system font with the specified weight and size use `Dynamic Type Size`.
    static func dynamicTypeSizeFont(size: CGFloat, weight: Weight, relativeTo textStyle: TextStyle) -> Font {
        #if canImport(UIKit)
        let fontFamily = UIFont.preferredFont(forTextStyle: .body).familyName
        return custom(fontFamily, size: size, relativeTo: textStyle).weight(weight)
        #elseif canImport(AppKit)
        let fontFamily = NSFont.preferredFont(forTextStyle: .body).familyName
        return custom(fontFamily, size: size, relativeTo: textStyle).weight(weight)
        #else
        fatalError("Unsupported UI platform")
        #endif
    }
}
