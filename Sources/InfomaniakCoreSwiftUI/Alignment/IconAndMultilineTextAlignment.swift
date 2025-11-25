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

public extension VerticalAlignment {
    /// Alignment ID used for the icon and the text
    /// The icon must be vertically centered with the first line of the text
    enum IconAndMultilineTextAlignment: AlignmentID {
        public static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context[.top]
        }
    }

    static let iconAndMultilineTextAlignment = VerticalAlignment(IconAndMultilineTextAlignment.self)
}

public extension View {
    func verticalAlignmentGuideForIcon() -> some View {
        alignmentGuide(.iconAndMultilineTextAlignment) { d in
            d[VerticalAlignment.center]
        }
    }

    func verticalAlignmentGuideForMultilineText() -> some View {
        alignmentGuide(.iconAndMultilineTextAlignment) { d in
            (d.height - (d[.lastTextBaseline] - d[.firstTextBaseline])) / 2
        }
    }
}
