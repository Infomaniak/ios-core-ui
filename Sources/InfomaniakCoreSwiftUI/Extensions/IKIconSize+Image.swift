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

import DesignSystem
import SwiftUI

public extension Image {
    /// Resizes and scales the image to the specified ``IKIconSize`` size.
    /// - Parameter size: The specified size.
    /// - Returns: A square view containing the image scaled to fit in a frame of the specified size.
    func iconSize(_ size: IKIconSize) -> some View {
        resizable()
            .scaledToFit()
            .frame(width: size.rawValue, height: size.rawValue)
    }
}
