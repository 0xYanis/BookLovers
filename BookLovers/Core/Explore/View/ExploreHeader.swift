//
//  ExploreHeader.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

struct ExploreHeader: View {
    @Binding var showSearchView: Bool
    
    @State private var searchText = ""
    @State private var placeholder = "books"
    @State private var counter = 0
    private let timer = Timer.publish(
        every: 2,
        on: .main,
        in: .common
    ).autoconnect()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading,  spacing: 15) {
                Text("Hello, Yanis")
                    .font(.subheadline)
                    .padding(.horizontal)
                
                Text("What are you looking for \ntoday?")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                
                TagCaruselView(
                    tags: LiteraryGenre.asArray,
                    onTap: tagTapped(_:)
                )
            }
            
            SearchBar("Search \(placeholder)", text: $searchText, isActive: false)
                .onTapGesture {
                    showSearchView.toggle()
                }
            .buttonStyle(.plain)
            .padding(.horizontal)
        }
        .onReceive(timer) { _ in
            if counter == LiteraryGenre.asArray.count {
                counter = 0
            }
            self.placeholder = LiteraryGenre.asArray[counter]
            counter += 1
        }
    }
    
    private func tagTapped(_ id: Int) {
        
    }
}

struct ExploreHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ExploreHeader(showSearchView: .constant(false))
        }
    }
}
