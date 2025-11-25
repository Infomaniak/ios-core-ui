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

import Foundation

/// An enumeration to list the paddings used for Infomaniak apps.
@frozen public enum IKPadding {
    @frozen public enum Option: CGFloat {
        /// 4pt padding
        case micro = 4
        /// 8pt padding
        case mini = 8
        /// 12pt padding
        case small = 12
        /// 16pt padding
        case medium = 16
        /// 24pt padding
        case large = 24
        /// 48pt padding
        case huge = 32
        /// 48pt padding
        case giant = 48
    }

    /// 4pt padding
    public static let micro: CGFloat = 4
    /// 8pt padding
    public static let mini: CGFloat = 8
    /// 12pt padding
    public static let small: CGFloat = 12
    /// 16pt padding
    public static let medium: CGFloat = 16
    /// 24pt padding
    public static let large: CGFloat = 24
    /// 32pt padding
    public static let huge: CGFloat = 32
    /// 48pt padding
    public static let giant: CGFloat = 48
}
