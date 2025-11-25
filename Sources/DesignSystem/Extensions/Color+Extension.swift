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

#if os(macOS)
public typealias PlatformColor = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
public typealias PlatformColor = UIColor
#endif

public extension PlatformColor {
    convenience init(light: PlatformColor, dark: PlatformColor) {
        self.init { $0.userInterfaceStyle == .dark ? dark : light }
    }
}

public extension Color {
    init(light: PlatformColor, dark: PlatformColor) {
        self.init(uiColor: UIColor(light: light, dark: dark))
    }
}
