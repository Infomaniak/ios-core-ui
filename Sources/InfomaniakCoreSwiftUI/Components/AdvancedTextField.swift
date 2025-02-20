/*
 Infomaniak Core UI - iOS
 Copyright (C) 2024 Infomaniak Network SA

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

public struct AdvancedTextField: UIViewRepresentable {
    @Binding var text: String

    private let placeholder: String?
    private let onSubmit: (() -> Void)?
    private let onBackspace: ((Bool) -> Void)?

    public init(
        text: Binding<String>,
        placeholder: String? = nil,
        onSubmit: (() -> Void)? = nil,
        onBackspace: ((Bool) -> Void)? = nil
    ) {
        _text = text
        self.placeholder = placeholder
        self.onSubmit = onSubmit
        self.onBackspace = onBackspace
    }

    public func makeUIView(context: Context) -> UIRecipientsTextField {
        let textField = UIRecipientsTextField(placeholder: placeholder, onBackspace: onBackspace)
        textField.delegate = context.coordinator
        textField.addTarget(context.coordinator, action: #selector(context.coordinator.textDidChanged(_:)), for: .editingChanged)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return textField
    }

    public func updateUIView(_ textField: UIRecipientsTextField, context: Context) {
        if textField.text != text {
            textField.text = text
        }
        textField.placeholder = placeholder
    }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    public class Coordinator: NSObject, UITextFieldDelegate {
        let parent: AdvancedTextField
        let submitKeys: [Character] = [" ", ","]

        init(_ parent: AdvancedTextField) {
            self.parent = parent
        }

        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            guard textField.text?.isEmpty == false else {
                textField.resignFirstResponder()
                return true
            }

            parent.onSubmit?()
            return true
        }

        @objc func textDidChanged(_ textField: UITextField) {
            if ((textField.text?.count ?? 0) - parent.text.count) > 1 {
                parent.text = textField.text ?? ""
                parent.onSubmit?()
            } else {
                parent.text = textField.text ?? ""
            }

            if submitKeys.contains(parent.text.last ?? "a") {
                parent.text.remove(at: parent.text.index(before: parent.text.endIndex))
                parent.onSubmit?()
            }
        }
    }
}

public final class UIRecipientsTextField: UITextField {
    let onBackspace: ((Bool) -> Void)?

    init(placeholder: String? = nil, onBackspace: ((Bool) -> Void)? = nil) {
        self.onBackspace = onBackspace
        super.init(frame: .zero)
        self.placeholder = placeholder

        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        textContentType = .emailAddress
        keyboardType = .emailAddress
        autocapitalizationType = .none
        autocorrectionType = .no
        font = .systemFont(ofSize: 16)
    }

    override public func deleteBackward() {
        onBackspace?(text?.isEmpty != false)
        super.deleteBackward()
    }
}

@available(iOS 17.0, *)
#Preview {
    @Previewable @State var text = ""

    AdvancedTextField(text: $text, placeholder: "Type Here") {
        print("Did Submit")
    } onBackspace: { isFieldEmpty in
        print("Did Type Backspace (\(isFieldEmpty))")
    }
    .onChange(of: text) { newValue in
        print("New Value: \(newValue)")
    }
}
