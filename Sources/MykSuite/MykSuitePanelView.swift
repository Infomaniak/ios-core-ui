//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 21/01/2025.
//

import SwiftUI

@available(iOS 15, *)
struct MykSuitePanelModifier: ViewModifier {
    @Binding var isPresented: Bool
    let configuration: [MykSuiteLabel]

    func body(content: Content) -> some View {
        content
            .floatingPanel(isPresented: $isPresented) {
                MyKsuiteView(configuration: configuration)
            }
    }
}

@available(iOS 15, *)
extension View {
    func mykSuitePanel(isPresented: Binding<Bool>, configuration: [MykSuiteLabel]) -> some View {
        modifier(MykSuitePanelModifier(isPresented: isPresented, configuration: configuration))
    }
}

@available(iOS 15, *)
#Preview {
    Text("OUI")
        .mykSuitePanel(isPresented: .constant(true), configuration: [])
}
