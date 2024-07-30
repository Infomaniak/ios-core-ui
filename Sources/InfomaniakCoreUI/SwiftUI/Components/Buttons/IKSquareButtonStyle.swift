//
//  File.swift
//  
//
//  Created by Valentin Perignon on 30.07.2024.
//

import SwiftUI

@available(iOS 15.0, *)
public struct IKSquareButtonStyle: ButtonStyle {
    @Environment(\.ikButtonLoading) private var isLoading: Bool

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .labelStyle(.ikButtonLabel)
            .modifier(IKButtonOpacityAnimationModifier(isPressed: configuration.isPressed))
            .modifier(IKButtonLoadingModifier(isFilled: true))
            .frame(width: IKButtonHeight.extraLarge, height: IKButtonHeight.extraLarge)
            .modifier(IKButtonFilledModifier())
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
                Button { } label: {
                    Image(systemName: "visionpro")
                        .iconSize(.medium)
                }
            }
        }
        .buttonStyle(.ikSquare)
        .navigationTitle("IKSquareButtonStyle")
    }
}
