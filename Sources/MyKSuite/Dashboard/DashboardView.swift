//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 22/01/2025.
//

import InfomaniakCoreSwiftUI
import SwiftUI

@available(iOS 15, *)
struct DashboardView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            SubscriptionCardView(type: .myKSuite)
                .padding(value: .medium)
                .navigationTitle(Text("myKSuiteDashboardTitle", bundle: .module))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(role: .destructive) {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }

                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

@available(iOS 15, *)
#Preview {
    DashboardView()
}
