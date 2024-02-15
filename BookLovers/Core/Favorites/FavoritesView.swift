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
                    selectedType: $selectedType,
                    offset: $offset
                )
                .zIndex(1)
                
                //main view
                TabView(selection: $selectedType) {
                    ForEach(FavoriteType.allCases) { type in
                        contentView
                            .tag(type)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var contentView: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<15, id: \.self) { _ in
                    FavoriteItem()
                        .padding(.top)
                        .padding(.horizontal)
                }
            }
            .scrollPosition(offset: $offset, in: "scroll")
        }
        .coordinateSpace(name: "scroll")
        .zIndex(0)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
