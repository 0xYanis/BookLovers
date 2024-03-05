//
//  AuthTextField.swift
//  BookLovers
//
//  Created by Yanis on 04.03.2024.
//

import SwiftUI

struct AuthTextField: View {
    private let image: String
    private let placeholder: String
    @Binding private var text: String
    private let isSecure: Bool
    
    init(
        image: String,
        placeholder: String,
        text: Binding<String>,
        isSecure: Bool = false
    ) {
        self.image = image
        self.placeholder = placeholder
        self._text = text
        self.isSecure = isSecure
    }
    
    var body: some View {
        HStack {
            if isSecure {
                Image(systemName: "lock.fill").frame(width: 22)
                SecureField(placeholder, text: $text)
            } else {
                Image(systemName: image).frame(width: 22)
                TextField(placeholder, text: $text)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
        .clipShape(Capsule())
        .animation(.easeIn(duration: 0.1), value: isSecure)
    }
}

// MARK: - Second init with FieldType parameter

extension AuthTextField {
    enum FieldType {
        case email, password, confirmation
    }
    
    init(_ type: FieldType, text: Binding<String>, isSecure: Bool = false) {
        switch type {
        case .email:
            self.init(image: "person.fill", placeholder: "Entry email", text: text)
        case .password:
            self.init(image: "lock.open.fill", placeholder: "Entry password", text: text, isSecure: isSecure)
        case .confirmation:
            self.init(image: "lock.open.fill", placeholder: "Confirm password", text: text, isSecure: isSecure)
        }
    }
}
