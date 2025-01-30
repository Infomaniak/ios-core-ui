//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 30/01/2025.
//

import SwiftUI

@available(iOS 15, *)
struct MyKSuiteDashboardSheetModifier: ViewModifier {
    @Binding var isPresented: Bool

    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                DashboardView()
            }
    }
}

@available(iOS 15, *)
public extension View {
    func myKSuiteDashboard(isPresented: Binding<Bool>) -> some View {
        modifier(MyKSuiteDashboardSheetModifier(isPresented: isPresented))
    }
}

@available(iOS 15, *)
#Preview {
    Text("Hello, world!")
        .myKSuiteDashboard(isPresented: .constant(true))
}
