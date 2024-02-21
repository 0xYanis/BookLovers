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
    @State private var isScrolling = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                FavoriteHeader(searchText: $searchText, selectedType: $selectedType)
                .zIndex(1)
                
                TabView(selection: $selectedType) {
                    ForEach(FavoriteType.allCases) { type in
                        if UIDevice.isiPhone {
                            contentView.tag(type)
                        } else {
                            contentPadView.tag(type)
                        }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var contentPadView: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                ForEach(0..<6, id: \.self) { index in
                    FavoriteItem()
                        .onChange(of: index) { newValue in
                            // TODO:
                        }
                }
            }
            .padding()
        }
    }
    
    private var contentView: some View {
        ScrollView {
            LazyVStack(spacing: 15) {
                ForEach(0..<15, id: \.self) { index in
                    FavoriteItem()
                        .padding(.horizontal)
                        .onChange(of: index) { newValue in
                            // TODO:
                        }
                }
            }
            .padding(.vertical)
        }
        .zIndex(0)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}

