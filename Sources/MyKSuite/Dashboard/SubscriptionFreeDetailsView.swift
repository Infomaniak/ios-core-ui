//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 23/01/2025.
//

import SwiftUI

@available(iOS 15.0, *)
struct SubscriptionFreeDetailsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Label {
                Text("myKSuiteDashboardFreeMailLabel", bundle: .module)
            } icon: {
                Image(systemName: "envelope")
                    .foregroundStyle(Color("elephant", bundle: .module))
            }

            DisclosureGroup {
                VStack(alignment: .leading, spacing: 8) {
                    Text("myKSuiteDashboardFunctionalityMailAndDrive", bundle: .module)
                    HStack {
                        Text("myKSuiteDashboardFunctionalityLimit", bundle: .module)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("!500")
                    }
                    Text("myKSuiteDashboardFunctionalityCustomReminders", bundle: .module)
                }
                .padding(.top, 18)
                .foregroundStyle(Color("elephant", bundle: .module))
                .font(.system(size: 14))
            } label: {
                Label {
                    Text("myKSuiteDashboardLimitedFunctionalityLabel", bundle: .module)
                } icon: {
                    Image(systemName: "lock")
                        .foregroundStyle(Color("elephant", bundle: .module))
                }
            }
        }
        .font(.system(size: 16))
        .foregroundStyle(Color("orca", bundle: .module))
    }
}

@available(iOS 15.0, *)
#Preview {
    SubscriptionFreeDetailsView()
}
