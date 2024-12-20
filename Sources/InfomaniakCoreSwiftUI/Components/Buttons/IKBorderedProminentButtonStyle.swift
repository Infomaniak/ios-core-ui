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
public struct IKBorderedProminentButtonStyle: ButtonStyle {
    @Environment(\.ikButtonLoading) private var isLoading

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .labelStyle(.ikLabel)
            .modifier(IKButtonOpacityAnimationModifier(isPressed: configuration.isPressed))
            .modifier(IKButtonLoadingModifier(isFilled: true))
            .modifier(IKButtonControlSizeModifier())
            .modifier(IKButtonLayout(isInlined: false))
            .modifier(IKButtonExpandableModifier())
            .modifier(IKButtonFilledModifier(buttonRole: configuration.role, isProminent: true))
            .allowsHitTesting(!isLoading)
    }
}

@available(iOS 15.0, *)
public extension ButtonStyle where Self == IKBorderedProminentButtonStyle {
    static var ikBorderedProminent: IKBorderedProminentButtonStyle {
        return IKBorderedProminentButtonStyle()
    }
}

@available(iOS 15.0, *)
#Preview {
    NavigationView {
        List {
            Section("Standard Button") {
                Button {} label: {
                    Label("Lorem Ipsum", systemImage: "visionpro")
                }
            }

            Section("Large Button") {
                Button {} label: {
                    Label("Lorem Ipsum", systemImage: "visionpro")
                }
                .controlSize(.large)
            }

            Section("Full Width Button") {
                Button {} label: {
                    Label("Lorem Ipsum", systemImage: "visionpro")
                }
                .controlSize(.large)
                .ikButtonFullWidth(true)
            }

            Section("Button With Different Colors") {
                Button {} label: {
                    Label("Lorem Ipsum", systemImage: "visionpro")
                }
                .ikButtonTheme(
                    IKButtonTheme(
                        primary: Color.purple,
                        secondary: Color.white,
                        tertiary: Color.gray,
                        disabledPrimary: Color.gray,
                        disabledSecondary: Color.white,
                        error: Color.red,
                        smallFont: .body,
                        mediumFont: .headline
                    )
                )
            }

            Section("Loading Button") {
                Button {} label: {
                    Label("Lorem Ipsum", systemImage: "visionpro")
                }
                .ikButtonLoading(true)
            }

            Section("Disabled Button") {
                Button {} label: {
                    Label("Lorem Ipsum", systemImage: "visionpro")
                }
                .disabled(true)
            }

            Section("Destructive Button") {
                Button(role: .destructive) {} label: {
                    Label("Lorem Ipsum", systemImage: "visionpro")
                }
            }
        }
        .buttonStyle(.ikBorderedProminent)
        .navigationTitle("IKBorderedProminentButtonStyle")
    }
}
