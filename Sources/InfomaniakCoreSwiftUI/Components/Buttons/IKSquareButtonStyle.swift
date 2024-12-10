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

import SwiftUI

@available(iOS 15.0, *)
public struct IKSquareButtonStyle: ButtonStyle {
    @Environment(\.ikButtonLoading) private var isLoading: Bool

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .labelStyle(.ikLabel)
            .modifier(IKButtonOpacityAnimationModifier(isPressed: configuration.isPressed))
            .modifier(IKButtonLoadingModifier(isFilled: true))
            .frame(width: IKButtonHeight.extraLarge, height: IKButtonHeight.extraLarge)
            .modifier(IKButtonFilledModifier(buttonRole: configuration.role, isProminent: true))
            .allowsHitTesting(!isLoading)
    }
}

@available(iOS 15.0, *)
public extension ButtonStyle where Self == IKSquareButtonStyle {
    static var ikSquare: IKSquareButtonStyle {
        return IKSquareButtonStyle()
    }
}

@available(iOS 15.0, *)
#Preview {
    NavigationView {
        List {
            Section("Standard Button") {
                Button {} label: {
                    Image(systemName: "visionpro")
                        .iconSize(.medium)
                }
            }
        }
        .buttonStyle(.ikSquare)
        .navigationTitle("IKSquareButtonStyle")
    }
}
