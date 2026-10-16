/*
 Infomaniak Core UI - iOS
 Copyright (C) 2026 Infomaniak Network SA

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

import DesignSystem
import SwiftUI

public enum IKFloatingActionButtonPlacement: Sendable {
    case floating
    case toolbar
}

public extension EnvironmentValues {
    @Entry
    var ikFloatingActionButtonPlacement = IKFloatingActionButtonPlacement.floating
}

public extension View {
    func ikFloatingActionButton<FAB: View>(
        isPresented: Bool = true,
        style: IKFloatingActionButtonStyle = .ikFloatingActionButton,
        @ViewBuilder button: () -> FAB
    ) -> some View {
        modifier(IKFloatingActionButtonModifier(isPresented: isPresented, style: style, button: button()))
    }
}

struct IKFloatingActionButtonModifier<FAB: View>: ViewModifier {
    @ObservedObject private var deviceHingeState = IKDeviceHingeState.shared

    let isPresented: Bool
    let style: IKFloatingActionButtonStyle
    let button: FAB

    private var placement: IKFloatingActionButtonPlacement {
        deviceHingeState.hasHinge ? .toolbar : .floating
    }

    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .bottom, alignment: .trailing) {
                if isPresented && placement == .floating {
                    button
                        .buttonStyle(style)
                        .padding([.trailing, .bottom], value: .medium)
                }
            }
            .modifier(IKToolbarFloatingActionButtonModifier(
                isPresented: isPresented && placement == .toolbar,
                isInactive: style.isInactive,
                button: button
            ))
            .detectDeviceHinge()
            .environment(\.ikFloatingActionButtonPlacement, placement)
    }
}

struct IKToolbarFloatingActionButtonModifier<FAB: View>: ViewModifier {
    @Environment(\.ikButtonTheme) private var theme

    let isPresented: Bool
    let isInactive: Bool
    let button: FAB

    private var tint: AnyShapeStyle {
        guard !(theme.primary is TintShapeStyle) else {
            return AnyShapeStyle(Color.accentColor)
        }
        return AnyShapeStyle(theme.primary)
    }

    func body(content: Content) -> some View {
        #if os(iOS)
        if #available(iOS 27.1, *) {
            content
                .toolbar {
                    if isPresented {
                        ToolbarSpacer(.flexible, placement: .bottomBar)

                        ToolbarItem(placement: .bottomBar) {
                            button
                                .buttonStyle(.borderedProminent)
                                .tint(tint)
                                .disabled(isInactive)
                        }
                    }
                }
        } else {
            content
        }
        #else
        content
        #endif
    }
}

#Preview {
    NavigationStack {
        List(0 ..< 50) { index in
            Text("Row \(index)")
        }
        .navigationTitle("Floating Action Button")
        .ikFloatingActionButton(style: .ikFloatingActionButton(isExtended: true)) {
            Button {
                /* Preview */
            } label: {
                Label("Lorem Ipsum", systemImage: "pencil")
            }
        }
    }
}
