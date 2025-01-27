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
                Text("!Une adresse mail gratuite à vie")
            } icon: {
                Image(systemName: "envelope")
                    .foregroundStyle(Color("elephant", bundle: .module))
            }

            DisclosureGroup {
                VStack(alignment: .leading, spacing: 8) {
                    Text("!Stockage pour Mail et kDrive")
                    HStack {
                        Text("!Envoi journaliers limités")
                        Text("!500")
                    }
                    Text("!Personnalisation des horaires indisponibles pour les rappels et renvois programmés")
                }
                .padding(.top, 18)
                .foregroundStyle(Color("elephant", bundle: .module))
                .font(.system(size: 14))
            } label: {
                Label {
                    Text("!Fonctionnalités limitées")
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
