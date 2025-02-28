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
    @State private var didPaste = false

    @Binding var text: String

    private let placeholder: String?
    private let submitKeys: Set<String>
    private let onSubmit: (() -> Void)?
    private let onBackspace: ((Bool) -> Void)?

    public init(
        text: Binding<String>,
        placeholder: String? = nil,
        submitKeys: Set<String> = [],
        onSubmit: (() -> Void)? = nil,
        onBackspace: ((Bool) -> Void)? = nil
    ) {
        _text = text
        self.placeholder = placeholder
        self.submitKeys = submitKeys
        self.onSubmit = onSubmit
        self.onBackspace = onBackspace
    }

    public func makeUIView(context: Context) -> UIRecipientsTextField {
        let textField = UIRecipientsTextField(placeholder: placeholder, onBackspace: onBackspace, onPaste: userDidPaste)
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

    private func userDidPaste() {
        didPaste = true
    }

    public class Coordinator: NSObject, UITextFieldDelegate {
        let parent: AdvancedTextField

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

        public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                              replacementString string: String) -> Bool {
            guard parent.submitKeys.contains(string) else {
                return true
            }

            parent.text = textField.text ?? ""
            parent.onSubmit?()
            return false
        }

        @objc func textDidChanged(_ textField: UITextField) {
            parent.text = textField.text ?? ""

            if parent.didPaste {
                parent.onSubmit?()
                parent.didPaste = false
            }
        }
    }
}

public final class UIRecipientsTextField: UITextField {
    let onBackspace: ((Bool) -> Void)?
    var onPaste: (() -> Void)?

    init(placeholder: String? = nil, onBackspace: ((Bool) -> Void)? = nil, onPaste: (() -> Void)? = nil) {
        self.onBackspace = onBackspace
        self.onPaste = onPaste
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

    override public func paste(_ sender: Any?) {
        super.paste(sender)
        onPaste?()
    }
}

@available(iOS 17.0, *)
#Preview {
    @Previewable @State var text = ""

    AdvancedTextField(text: $text, placeholder: "Type Here", submitKeys: [","]) {
        print("Did Submit \"\(text)\"")
    } onBackspace: { isFieldEmpty in
        print("Did Type Backspace (\(isFieldEmpty))")
    }
    .onChange(of: text) { newValue in
        print("New Value: \(newValue)")
    }
}
