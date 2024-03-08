//
//  SearchBar.swift
//  BookLovers
//
//  Created by Yanis on 07.02.2024.
//

import SwiftUI

struct SearchBar: View {
    var placeholder: String
    @Binding var text: String
    let isActive: Bool
    
    init(_ placeholder: String, text: Binding<String>, isActive: Bool = true) {
        self.placeholder = placeholder
        self._text = text
        self.isActive = isActive
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "magnifyingglass")
                .imageScale(.large)
                .foregroundStyle(.secondary)
            if isActive {
                TextField(placeholder, text: $text)
                    .padding(.horizontal, 3)
                    .padding(.vertical, 7)
            } else {
                Text(placeholder)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 3)
                    .padding(.vertical, 7)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
