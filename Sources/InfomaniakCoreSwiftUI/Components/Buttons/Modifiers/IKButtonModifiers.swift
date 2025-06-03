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

import DesignSystem
import SwiftUI

// MARK: - Loading Effect

@available(iOS 15.0, *)
public struct IKButtonLoadingModifier: ViewModifier {
    @Environment(\.ikButtonLoading) private var isLoading

    let isFilled: Bool

    public init(isFilled: Bool) {
        self.isFilled = isFilled
    }

    public func body(content: Content) -> some View {
        ZStack {
            content
                .opacity(isLoading ? 0 : 1)

            ProgressView()
                .progressViewStyle(.circular)
                .controlSize(.regular)
                .tint(isFilled ? .white : nil)
                .opacity(isLoading ? 1 : 0)
        }
    }
}

// MARK: - Control Size

@available(iOS 15.0, *)
public struct IKButtonControlSizeModifier: ViewModifier {
    @Environment(\.controlSize) private var controlSize
    @Environment(\.ikButtonTheme) private var theme

    public init() {}

    public func body(content: Content) -> some View {
        content
            .font(theme.scaledFont(controlSize))
    }
}

// MARK: - Expandable Button

@available(iOS 15.0, *)
public struct IKButtonExpandableModifier: ViewModifier {
    @Environment(\.ikButtonFullWidth) private var isFullWidth

    public init() {}

    public func body(content: Content) -> some View {
        content
            .frame(maxWidth: isFullWidth ? IKButtonConstants.maxWidth : nil)
    }
}

// MARK: - Layout

@available(iOS 15.0, *)
public struct IKButtonLayout: ViewModifier {
    @Environment(\.controlSize) private var controlSize

    let isInlined: Bool

    private var minHeight: CGFloat? {
        guard !isInlined else { return nil }
        return IKButtonHeight.convert(controlSize: controlSize)
    }

    private var verticalPadding: CGFloat {
        guard !isInlined else { return 0 }
        return controlSize == .large ? IKPadding.medium : IKPadding.mini
    }

    public init(isInlined: Bool) {
        self.isInlined = isInlined
    }

    public func body(content: Content) -> some View {
        content
            .padding(.horizontal, isInlined ? 0 : IKPadding.large)
            .padding(.vertical, verticalPadding)
            .frame(minHeight: minHeight)
    }
}

// MARK: - Tap Animation

enum IKButtonTapAnimation {
    case scale, opacity
}

@available(iOS 15.0, *)
public struct IKButtonScaleAnimationModifier: ViewModifier {
    let isPressed: Bool

    public init(isPressed: Bool) {
        self.isPressed = isPressed
    }

    public func body(content: Content) -> some View {
        content
            .brightness(isPressed ? 0.1 : 0)
            .scaleEffect(isPressed ? 0.95 : 1.0)
    }
}

public struct IKButtonOpacityAnimationModifier: ViewModifier {
    let isPressed: Bool

    public init(isPressed: Bool) {
        self.isPressed = isPressed
    }

    public func body(content: Content) -> some View {
        content
            .opacity(isPressed ? 0.4 : 1.0)
    }
}

// MARK: - Filled Button

@available(iOS 15.0, *)
public struct IKButtonFilledModifier: ViewModifier {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.ikButtonTheme) private var theme
    @Environment(\.ikButtonLoading) private var isLoading

    let buttonRole: ButtonRole?
    let isProminent: Bool

    private var isDisabled: Bool {
        return !isEnabled || isLoading
    }

    private var foregroundStyle: any ShapeStyle {
        guard !isDisabled else {
            return theme.disabledSecondary
        }
        return isProminent ? theme.secondary : theme.primary
    }

    private var backgroundStyle: any ShapeStyle {
        if isDisabled {
            return theme.disabledPrimary
        } else if buttonRole == .destructive {
            return theme.error
        } else {
            return isProminent ? theme.primary : theme.tertiary
        }
    }

    public init(buttonRole: ButtonRole?, isProminent: Bool) {
        self.buttonRole = buttonRole
        self.isProminent = isProminent
    }

    public func body(content: Content) -> some View {
        content
            .foregroundStyle(AnyShapeStyle(foregroundStyle))
            .background(AnyShapeStyle(backgroundStyle), in: RoundedRectangle(cornerRadius: IKRadius.large))
    }
}
