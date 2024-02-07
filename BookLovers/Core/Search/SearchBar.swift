//
//  SearchBar.swift
//  BookLovers
//
//  Created by Yanis on 07.02.2024.
//

import SwiftUI

struct SearchBar: View {
    @State private var text = ""
    @State private var placeholder = "books"
    @State private var normalState = true
    @FocusState private var isFocused: Bool
    
    @State private var counter = 0
    private let timer = Timer.publish(
        every: 2,
        on: .main,
        in: .common
    ).autoconnect()
    
    var body: some View {
        HStack(spacing: 0) {
            if normalState {
                Image(systemName: "magnifyingglass")
                    .imageScale(.large)
                    .foregroundStyle(.secondary)
            }
            TextField("Search \(placeholder)", text: $text)
                .focused($isFocused)
                .padding(.horizontal, 3)
                .padding(.vertical, 7)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1.0)
                .foregroundStyle(.secondary))
        .padding(.horizontal)
        .onReceive(timer) { _ in
            if normalState {
                if counter == LiteraryGenre.asArray.count {
                    counter = 0
                }
                self.placeholder = LiteraryGenre.asArray[counter]
                counter += 1
            }
        }
    }
}
