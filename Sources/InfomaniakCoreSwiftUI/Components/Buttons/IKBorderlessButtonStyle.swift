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
public struct IKBorderlessButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    @Environment(\.ikButtonTheme) private var theme
    @Environment(\.ikButtonLoading) private var isLoading

    var isInlined = false

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .labelStyle(.ikButtonLabel)
            .foregroundStyle(AnyShapeStyle(foreground(role: configuration.role)))
            .modifier(IKButtonLoadingModifier(isFilled: false))
            .modifier(IKButtonControlSizeModifier())
            .modifier(IKButtonExpandableModifier())
            .modifier(IKButtonLayout(isInlined: isInlined))
            .contentShape(Rectangle())
            .modifier(IKButtonOpacityAnimationModifier(isPressed: configuration.isPressed))
            .allowsHitTesting(!isLoading)
    }

    private func foreground(role: ButtonRole?) -> any ShapeStyle {
        if !isEnabled || isLoading {
            return theme.disabledPrimary
        } else if role == .destructive {
            return theme.error
        } else {
            return theme.primary
        }
    }
}

@available(iOS 15.0, *)
public extension ButtonStyle where Self == IKBorderlessButtonStyle {
    static func ikBorderless(isInlined: Bool) -> IKBorderlessButtonStyle {
        return IKBorderlessButtonStyle(isInlined: isInlined)
    }

    static var ikBorderless: IKBorderlessButtonStyle {
        return IKBorderlessButtonStyle()
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

            Section("Destructive Button") {
                Button(role: .destructive) {} label: {
                    Label("Lorem Ipsum", systemImage: "visionpro")
                }
            }

            Section("Small Button") {
                Button {} label: {
                    Label("Lorem Ipsum", systemImage: "visionpro")
                }
                .controlSize(.small)
            }

            Section("Full Width Button") {
                Button {} label: {
                    Label("Lorem Ipsum", systemImage: "visionpro")
                }
                .controlSize(.large)
                .ikButtonFullWidth(true)
            }

            Section("Button With Different Color") {
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

            Section("Inlined Button") {
                Button {} label: {
                    Label("Lorem Ipsum", systemImage: "visionpro")
                }
                .buttonStyle(.ikBorderless(isInlined: true))
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
        }
        .buttonStyle(.ikBorderless)
        .navigationTitle("IKPlainButtonStyle")
    }
}
