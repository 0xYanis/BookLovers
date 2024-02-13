//
//  FavoritesView.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

struct FavoritesView: View {
    @State private var searchText = ""
    @State private var selectedType: FavoriteType = .onReading
    @State private var requestSignIn = false
    @State private var offset: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                //header
                FavoriteHeader(
                    searchText: $searchText,
                    selectedType: $selectedType
                )
                
                //main view
                ScrollView {
                    Rectangle()
                        .fill(.red)
                        .frame(height: 900)
                        .padding()
                        .scrollPosition(offset: $offset, in: "scroll")
                }
                .coordinateSpace(name: "scroll")
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
