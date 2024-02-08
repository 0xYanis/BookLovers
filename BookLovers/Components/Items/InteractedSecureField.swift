//
//  InteractedSecureField.swift
//  BookLovers
//
//  Created by Yanis on 07.02.2024.
//

import SwiftUI

struct InteractedSecureField: View {
    private var placeholder: String
    @Binding private var text: String
    @State private var isSecure = true
    
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
    
    var body: some View {
        HStack(spacing: 4) {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .padding(.vertical, 12)
            } else {
                TextField(placeholder, text: $text)
                    .padding(.vertical, 12)
            }
            
            Button {
                withAnimation(.linear(duration: 0.1)) {
                    isSecure.toggle()
                }
            } label: {
                Image(systemName: isSecure ? "eye.slash" : "eye")
                    .imageScale(.medium)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal)
    }
}
