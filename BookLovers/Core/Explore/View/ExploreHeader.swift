//
//  ExploreHeader.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

struct ExploreHeader: View {
    @State private var searchText = ""
    @State private var normalState = true
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading,  spacing: 15) {
                if normalState {
                    Text("Hello, Yanis")
                        .font(.subheadline)
                        .padding(.horizontal)
                    
                    Text("What are you looking for \ntoday?")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    TagCaruselView(
                        tags: LiteraryGenre.asArray,
                        font: .body,
                        onTap: tagTapped(_:)
                    )
                }
            }
            .onChange(of: isFocused) { state in
                withAnimation(.spring(response: 0.3)) {
                    normalState = !state
                }
            }
            
            HStack(spacing: 0) {
                if normalState {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                        .foregroundStyle(.secondary)
                }
                TextField("Search books", text: $searchText)
                    .focused($isFocused)
                    .padding(.horizontal, 3)
                    .padding(.vertical, 7)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.0)
                    .foregroundStyle(.secondary))
            .padding(.horizontal)
        }
    }
    
    private func tagTapped(_ id: Int) {
        
    }
}

struct ExploreHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ExploreHeader()
        }
    }
}
