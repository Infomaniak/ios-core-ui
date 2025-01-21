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
    let type: MykSuiteType

    func body(content: Content) -> some View {
        content
            .floatingPanel(isPresented: $isPresented) {
                MyKsuiteView(type: type)
            }
    }
}

@available(iOS 15, *)
extension View {
    func mykSuitePanel(isPresented: Binding<Bool>, type: MykSuiteType) -> some View {
        modifier(MyModifier(isPresented: isPresented, type: type))
    }
}
