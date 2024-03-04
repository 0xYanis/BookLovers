//
//  AuthTextField.swift
//  BookLovers
//
//  Created by Yanis on 04.03.2024.
//

import SwiftUI

struct AuthTextField: View {
    let image: String
    let placeholder: String
    @Binding var text: String
    let isSecure: Bool
    
    init(image: String, placeholder: String, text: Binding<String>, isSecure: Bool = false) {
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
