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

    var isExtended = false
    var customSize: CGFloat?

    private var size: CGFloat {
        if let customSize {
            return customSize
        } else if controlSize == .large {
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
            .modifier(IKButtonFilledModifier(isProminent: true))
            .modifier(IKButtonScaleAnimationModifier(isPressed: configuration.isPressed))
            .allowsHitTesting(!isLoading)
    }
}

@available(iOS 15.0, *)
public extension ButtonStyle where Self == IKFloatingActionButtonStyle {
    static func ikFloatingActionButton(isExtended: Bool = false, customSize: CGFloat? = nil) -> IKFloatingActionButtonStyle {
        return IKFloatingActionButtonStyle(isExtended: isExtended, customSize: customSize)
    }

    static var ikFloatingActionButton: IKFloatingActionButtonStyle {
        return IKFloatingActionButtonStyle()
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
            }

            Section("Extended Button") {
                Button {
                    /* Preview */
                } label: {
                    Label("Lorem Ipsum", systemImage: "visionpro")
                }
                .buttonStyle(.ikFloatingActionButton(isExtended: true))
            }

            Section("Large Button") {
                Button {
                    /* Preview */
                } label: {
                    Image(systemName: "visionpro")
                        .iconSize(.large)
                }
                .controlSize(.large)
            }

            Section("Custom Size Button") {
                Button {
                    /* Preview */
                } label: {
                    Image(systemName: "visionpro")
                        .iconSize(.large)
                }
                .buttonStyle(.ikFloatingActionButton(customSize: 80))
            }

            Section("Loading Button") {
                Button {
                    /* Preview */
                } label: {
                    Image(systemName: "visionpro")
                        .iconSize(.medium)
                }
                .ikButtonLoading(true)
            }

            Section("Loading Extended Button") {
                Button {
                    /* Preview */
                } label: {
                    Label("Lorem Ipsum", systemImage: "visionpro")
                }
                .buttonStyle(.ikFloatingActionButton(isExtended: true))
                .ikButtonLoading(true)
            }

            Section("Disabled Button") {
                Button {
                    /* Preview */
                } label: {
                    Label("Lorem Ipsum", systemImage: "visionpro")
                }
                .buttonStyle(.ikFloatingActionButton(isExtended: true))
                .disabled(true)
            }
        }
        .navigationTitle("IKFloatingActionButtonStyle")
        .buttonStyle(.ikFloatingActionButton)
    }
}
