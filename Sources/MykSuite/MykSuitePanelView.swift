//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 21/01/2025.
//

import SwiftUI

@available(iOS 15, *)
struct MyModifier: ViewModifier {
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
        modifier(MyModifier(isPresented: isPresented, configuration: configuration))
    }
}
