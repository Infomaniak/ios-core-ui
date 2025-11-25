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

import Lottie
import SwiftUI

public struct ThemedLottieView: View {
    @Environment(\.colorScheme) private var colorScheme

    let lightAnimationName: String
    let darkAnimationName: String?

    let bundle: Bundle

    let loopMode: Lottie.LottieLoopMode

    private var animationName: String {
        if colorScheme == .dark,
           let darkAnimationName {
            return darkAnimationName
        } else {
            return lightAnimationName
        }
    }

    public init(
        lightAnimationName: String,
        darkAnimationName: String? = nil,
        bundle: Bundle,
        loopMode: Lottie.LottieLoopMode = .autoReverse
    ) {
        self.lightAnimationName = lightAnimationName
        self.darkAnimationName = darkAnimationName
        self.bundle = bundle
        self.loopMode = loopMode
    }

    public var body: some View {
        LottieView {
            try await LottieAnimationSource.dotLottieFile(.named(animationName, bundle: bundle))
        }
        .playing(loopMode: loopMode)
        .id(colorScheme)
    }
}
