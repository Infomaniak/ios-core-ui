//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 30/01/2025.
//

import InfomaniakCore
import SwiftUI

@available(iOS 15, *)
struct MyKSuiteDashboardSheetModifier: ViewModifier {
    @Binding var isPresented: Bool
    let apiFetcher: ApiFetcher

    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                DashboardView(apiFetcher: apiFetcher)
            }
    }
}

@available(iOS 15, *)
public extension View {
    func myKSuiteDashboard(isPresented: Binding<Bool>, apiFetcher: ApiFetcher) -> some View {
        modifier(MyKSuiteDashboardSheetModifier(isPresented: isPresented, apiFetcher: apiFetcher))
    }
}

@available(iOS 15, *)
#Preview {
    Text("Hello, world!")
        .myKSuiteDashboard(isPresented: .constant(true), apiFetcher: ApiFetcher())
}
