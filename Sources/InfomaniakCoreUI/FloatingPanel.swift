//
//  File.swift
//
//
//  Created by Ambroise Decouttere on 02/10/2023.
//

import Combine
import SwiftUI
import SwiftUIBackports
import SwiftUIIntrospect

@available(iOS 15, *)
extension View {
    func floatingPanel<Content: View>(isPresented: Binding<Bool>,
                                      @ViewBuilder content: @escaping () -> Content) -> some View {
        sheet(isPresented: isPresented) {
            if #available(iOS 16.0, *) {
                content().modifier(SelfSizingPanelViewModifier())
            } else {
                content().modifier(SelfSizingPanelBackportViewModifier())
            }
        }
    }

    func floatingPanel<Item: Identifiable, Content: View>(item: Binding<Item?>,
                                                          @ViewBuilder content: @escaping (Item) -> Content) -> some View {
        sheet(item: item) { item in
            if #available(iOS 16.0, *) {
                content(item).modifier(SelfSizingPanelViewModifier())
            } else {
                content(item).modifier(SelfSizingPanelBackportViewModifier())
            }
        }
    }

    func ikPresentationCornerRadius(_ cornerRadius: CGFloat?) -> some View {
        if #available(iOS 16.4, *) {
            return presentationCornerRadius(cornerRadius)
        } else {
            return introspect(.viewController, on: .iOS(.v15)) { viewController in
                viewController.sheetPresentationController?.preferredCornerRadius = cornerRadius
            }
        }
    }
}

@available(iOS, introduced: 15, deprecated: 16, message: "Use native way")
struct SelfSizingPanelBackportViewModifier: ViewModifier {
    @State var currentDetents: Set<Backport.PresentationDetent> = [.medium]
    private let topPadding: CGFloat = 24

    func body(content: Content) -> some View {
        ScrollView {
            content
                .padding(.bottom, 16)
        }
        .padding(.top, topPadding)
        .introspect(.scrollView, on: .iOS(.v15)) { scrollView in
            guard !currentDetents.contains(.large) else { return }
            let totalPanelContentHeight = scrollView.contentSize.height + topPadding

            scrollView.isScrollEnabled = totalPanelContentHeight > (scrollView.window?.bounds.height ?? 0)
            if totalPanelContentHeight > (scrollView.window?.bounds.height ?? 0) / 2 {
                currentDetents = [.medium, .large]
            }
        }
        .backport.presentationDragIndicator(.visible)
        .backport.presentationDetents(currentDetents)
        .ikPresentationCornerRadius(20)
    }
}

@available(iOS 16.0, *)
struct SelfSizingPanelViewModifier: ViewModifier {
    @State var currentDetents: Set<PresentationDetent> = [.height(0)]
    @State var selection: PresentationDetent = .height(0)
    private let topPadding: CGFloat = 24

    func body(content: Content) -> some View {
        ScrollView {
            content
                .padding(.bottom, 16)
        }
        .padding(.top, topPadding)
        .introspect(.scrollView, on: .iOS(.v16, .v17)) { scrollView in
            let totalPanelContentHeight = scrollView.contentSize.height + topPadding
            guard selection != .height(totalPanelContentHeight) else { return }

            scrollView.isScrollEnabled = totalPanelContentHeight > (scrollView.window?.bounds.height ?? 0)
            DispatchQueue.main.async {
                currentDetents = [.height(0), .height(totalPanelContentHeight)]
                selection = .height(totalPanelContentHeight)

                // Hack to let time for the animation to finish, after animation is complete we can modify the state again
                // if we don't do this the animation is cut before finishing
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    currentDetents = [selection]
                }
            }
        }
        .presentationDetents(currentDetents, selection: $selection)
        .presentationDragIndicator(.visible)
        .ikPresentationCornerRadius(20)
    }
}
