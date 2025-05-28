/*
 Infomaniak Core UI - iOS
 Copyright (C) 2023 Infomaniak Network SA

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

import DesignSystem
import InfomaniakCoreCommonUI
import InfomaniakCoreUIResources
import OSLog
import SwiftUI

public struct ModalButtonsView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var isButtonLoading = false

    private let primaryButtonTitle: String
    private var secondaryButtonTitle: String?
    private var primaryButtonEnabled = true
    private let primaryButtonAction: () async throws -> Void
    private var secondaryButtonAction: (() -> Void)?
    private var primaryButtonRole: ButtonRole?

    public init(
        primaryButtonTitle: String,
        secondaryButtonTitle: String? = CoreUILocalizable.buttonCancel,
        primaryButtonEnabled: Bool = true,
        primaryButtonAction: @escaping () async throws -> Void,
        secondaryButtonAction: (() -> Void)? = nil,
        primaryButtonRole: ButtonRole? = nil
    ) {
        self.primaryButtonTitle = primaryButtonTitle
        self.primaryButtonEnabled = primaryButtonEnabled
        self.secondaryButtonTitle = secondaryButtonTitle
        self.primaryButtonAction = primaryButtonAction
        self.secondaryButtonAction = secondaryButtonAction
        self.primaryButtonRole = primaryButtonRole
    }

    public var body: some View {
        HStack(spacing: IKPadding.micro) {
            if let secondaryButtonTitle {
                Button {
                    secondaryButtonAction?()
                    dismiss()
                } label: {
                    Text(secondaryButtonTitle)
                }
                .buttonStyle(.ikBorderless)
                .keyboardShortcut(.cancelAction)
            }

            Button(primaryButtonTitle, role: primaryButtonRole) {
                Task {
                    isButtonLoading = true
                    do {
                        try await primaryButtonAction()
                        dismiss()
                    } catch {
                        Logger.view.warning("\(error)")
                    }
                    isButtonLoading = false
                }
            }
            .buttonStyle(.ikBorderedProminent)
            .disabled(!primaryButtonEnabled)
            .ikButtonLoading(isButtonLoading)
            .keyboardShortcut(.defaultAction)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

#Preview {
    ModalButtonsView(primaryButtonTitle: "Save", secondaryButtonTitle: nil) { /* Preview */ }
}
