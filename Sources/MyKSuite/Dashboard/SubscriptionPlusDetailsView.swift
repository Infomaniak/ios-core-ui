//
//  SwiftUIView.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 27/01/2025.
//

import SwiftUI

@available(iOS 15.0, *)
struct SubscriptionPlusDetailsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Text("!Période d'essai")
                    .foregroundStyle(Color("orca", bundle: .module))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("!Jusqu'au xx/xx/xxxx")
                    .foregroundStyle(Color("elephant", bundle: .module))
            }

            HStack {
                Text("!Mode de paiement")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color("orca", bundle: .module))
                Text("!Apple Pay")
                    .foregroundStyle(Color("elephant", bundle: .module))
            }

            HStack(alignment: .top, spacing: 12) {
                Image("information", bundle: .module)
                    .foregroundStyle(Color("elephant", bundle: .module))

                VStack(alignment: .leading, spacing: 16) {
                    Text(
                        "!Pour résilier ou modifier la périodicité de votre abonnement, rendez-vous dans vos réglages Apple Store."
                    )
                    .foregroundStyle(Color("orca", bundle: .module))

                    Button {
                        // Gerer mon abonnement
                    } label: {
                        Text("!Gérer mon abonnement")
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(value: .medium)
            .background(Color("polar.bear", bundle: .module), in: .rect(cornerRadius: 8))
        }
    }
}

@available(iOS 15.0, *)
#Preview {
    SubscriptionPlusDetailsView()
}
