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

public struct InitialsView: View {
    let initials: String
    let backgroundColor: Color
    let foregroundColor: Color
    let size: CGFloat

    public init(initials: String, backgroundColor: Color, foregroundColor: Color, size: CGFloat) {
        self.initials = initials
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.size = size
    }

    public var body: some View {
        ZStack {
            Circle()
                .fill(backgroundColor)
            Text(initials)
                .font(.system(size: size * 0.5, weight: .semibold))
                .foregroundStyle(foregroundColor)
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    InitialsView(initials: "TE", backgroundColor: .red, foregroundColor: .white, size: 40)
}
