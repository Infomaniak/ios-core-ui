//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 14/10/2024.
//

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
