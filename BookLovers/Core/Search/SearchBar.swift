//
//  SearchBar.swift
//  BookLovers
//
//  Created by Yanis on 07.02.2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "magnifyingglass")
                .imageScale(.large)
                .foregroundStyle(.secondary)
            TextField("Search books", text: $text)
                .padding(.horizontal, 3)
                .padding(.vertical, 7)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(RoundedRectangle(cornerRadius: 10)
            .stroke(lineWidth: 1.0)
            .foregroundStyle(.secondary))
    }
}
