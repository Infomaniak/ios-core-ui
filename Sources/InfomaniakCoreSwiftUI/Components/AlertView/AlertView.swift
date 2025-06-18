/*
 Infomaniak Core UI - iOS
 Copyright (C) 2025 Infomaniak Network SA

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

import SwiftUI
import SwiftUIIntrospect

public struct AlertView<Content>: View where Content: View {
    @State private var isShowing = false

    private let content: Content
    private let backgroundColor: Color
    private let maxWidth: CGFloat

    public init(
        backgroundColor: Color,
        maxWidth: CGFloat = 496,
        @ViewBuilder content: () -> Content
    ) {
        self.backgroundColor = backgroundColor
        self.maxWidth = maxWidth
        self.content = content()
    }

    var viewContent: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()

            content
                .padding(value: .large)
                .background(backgroundColor)
                .cornerRadius(16)
                .frame(maxWidth: maxWidth)
                .padding(value: .large)
        }
        .opacity(isShowing ? 1 : 0)
        .onAppear {
            guard !isShowing else { return }
            Task {
                try await Task.sleep(nanoseconds: UInt64(0.25 * Double(NSEC_PER_SEC)))
                withAnimation(.easeInOut(duration: 0.25)) {
                    isShowing = true
                }
            }
        }
        .introspect(.viewController, on: .iOS(.v15, .v16, .v17, .v18, .v26)) { viewController in
            viewController.modalTransitionStyle = .crossDissolve
        }
    }

    public var body: some View {
        if #available(iOS 16.4, *) {
            viewContent.presentationBackground(Color.clear)
        } else {
            viewContent.background(ClearFullScreenView())
        }
    }
}

struct CustomAlertModifier<AlertContent>: ViewModifier where AlertContent: View {
    @Binding var isPresented: Bool

    let backgroundColor: Color

    @ViewBuilder let alertView: AlertContent

    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                AlertView(backgroundColor: backgroundColor) {
                    alertView
                }
            }
    }
}

struct CustomAlertItemModifier<Item, AlertContent>: ViewModifier where Item: Identifiable, AlertContent: View {
    @Binding var item: Item?

    let backgroundColor: Color
    let alertView: (Item) -> AlertContent

    func body(content: Content) -> some View {
        content
            .fullScreenCover(item: $item) { item in
                AlertView(backgroundColor: backgroundColor) {
                    alertView(item)
                }
            }
    }
}

private struct ClearFullScreenView: UIViewRepresentable {
    private static let maxSearchDepth = 5
    private class BackgroundRemovalView: UIView {
        override func didMoveToWindow() {
            super.didMoveToWindow()
            clearBackgroundSuperviews(view: self)
        }

        private func clearBackgroundSuperviews(view: UIView, level: Int = 0) {
            guard level < maxSearchDepth else { return }

            if let superview = view.superview {
                superview.backgroundColor = .clear
                clearBackgroundSuperviews(view: superview, level: level + 1)
            }
        }
    }

    func makeUIView(context: Context) -> UIView {
        return BackgroundRemovalView()
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

public extension View {
    func customAlert<Content: View>(
        isPresented: Binding<Bool>,
        backgroundColor: Color,
        @ViewBuilder content: () -> Content
    ) -> some View {
        modifier(CustomAlertModifier(isPresented: isPresented, backgroundColor: backgroundColor, alertView: content))
    }

    func customAlert<Item, Content>(
        item: Binding<Item?>,
        backgroundColor: Color,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View
        where Item: Identifiable, Content: View {
        modifier(CustomAlertItemModifier(item: item, backgroundColor: backgroundColor, alertView: content))
    }
}

#Preview {
    AlertView(backgroundColor: Color(uiColor: .systemBackground)) {
        Text("Some alert text")
    }
}

@available(iOS 17.0, *)
#Preview {
    @Previewable @State var isPresented = false

    Button("Open Alert") {
        isPresented = true
    }
    .customAlert(isPresented: $isPresented, backgroundColor: Color(uiColor: .systemBackground)) {
        VStack {
            Text("Some alert text")
            Button("Close") {
                isPresented = false
            }
        }
    }
}
