/*
 Infomaniak Core UI - iOS
 Copyright (C) 2024 Infomaniak Network SA

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

@available(iOS 15.0, *)
public struct FloatingPanelCloseButton: View {
    let size: IKIconSize?
    let dismissHandler: () -> Void

    public init(size: IKIconSize? = nil, dismissHandler: @escaping () -> Void) {
        self.size = size
        self.dismissHandler = dismissHandler
    }

    public init(size: IKIconSize? = nil, dismissAction: DismissAction) {
        self.size = size
        dismissHandler = dismissAction.callAsFunction
    }

    public var body: some View {
        Button(action: dismissHandler) {
            Label {
                Text("Close", bundle: .module)
            } icon: {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size?.rawValue, height: size?.rawValue)
            }
        }
        .labelStyle(.iconOnly)
        .keyboardShortcut(.cancelAction)
    }
}

@available(iOS 15.0, *)
#Preview {
    FloatingPanelCloseButton { /* Preview */ }
}
