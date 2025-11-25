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

public struct AvatarImage: View {
    let image: Image
    let size: CGFloat

    public init(image: Image, size: CGFloat) {
        self.image = image
        self.size = size
    }

    public var body: some View {
        ZStack {
            Circle()
                .fill(.white)

            image
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
        }
        .frame(width: size, height: size)
        .drawingGroup()
    }
}

#Preview {
    AvatarImage(image: Image(systemName: "person"), size: 40)
}
