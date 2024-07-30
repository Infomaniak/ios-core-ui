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
public struct IKFloatingActionButtonStyle: ButtonStyle {
    @Environment(\.controlSize) private var controlSize
    @Environment(\.ikButtonTheme) private var theme
    @Environment(\.ikButtonLoading) private var isLoading

    let isExtended: Bool

    private var size: CGFloat {
        if controlSize == .large {
            return IKButtonHeight.extraLarge
        } else {
            return IKButtonHeight.large
        }
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .labelStyle(.ikButtonLabel)
            .modifier(IKButtonLoadingModifier(isFilled: true))
            .font(theme.mediumFont)
            .padding(.horizontal, IKPadding.medium)
            .frame(minWidth: isExtended ? nil : size, minHeight: size)
            .modifier(IKButtonFilledModifier())
            .modifier(IKButtonScaleAnimationModifier(isPressed: configuration.isPressed))
            .allowsHitTesting(!isLoading)
    }
}

@available(iOS 15.0, *)
public extension ButtonStyle where Self == IKFloatingActionButtonStyle {
    static func ikFloatingActionButton(isExtended: Bool) -> IKFloatingActionButtonStyle {
        return IKFloatingActionButtonStyle(isExtended: isExtended)
    }
}

@available(iOS 15.0, *)
#Preview {
    NavigationView {
        List {
            Section("Standard Button") {
                Button {
                    /* Preview */
                } label: {
                    Image(systemName: "visionpro")
                        .iconSize(.medium)
                }
                .buttonStyle(.ikFloatingActionButton(isExtended: false))
            }

            Section("Extended Button") {
                Button {
                    /* Preview */
                } label: {
                    Label("Lorem Ipsum", systemImage: "visionpro")
                }
            }

            Section("Large FAB") {
                Button {
                    /* Preview */
                } label: {
                    Image(systemName: "visionpro")
                        .iconSize(.large)
                }
                .buttonStyle(.ikFloatingActionButton(isExtended: false))
                .controlSize(.large)
            }

            Section("Loading Button") {
                Button {
                    /* Preview */
                } label: {
                    Image(systemName: "visionpro")
                        .iconSize(.medium)
                }
                .buttonStyle(.ikFloatingActionButton(isExtended: false))
                .ikButtonLoading(true)
            }

            Section("Loading Extended Button") {
                Button {
                    /* Preview */
                } label: {
                    Label("Lorem Ipsum", systemImage: "visionpro")
                }
                .ikButtonLoading(true)
            }

            Section("Disabled Button") {
                Button {
                    /* Preview */
                } label: {
                    Label("Lorem Ipsum", systemImage: "visionpro")
                }
                .disabled(true)
            }
        }
        .navigationTitle("IKFloatingActionButtonStyle")
        .buttonStyle(.ikFloatingActionButton(isExtended: true))
    }
}

