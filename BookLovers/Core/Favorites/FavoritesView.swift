//
//  FavoritesView.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI
import ScalingHeaderScrollView

struct FavoritesView: View {
    @State private var searchText = ""
    @State private var selectedType: FavoriteType = .onReading
    @State private var requestSignIn = false
    @State private var headerSize = CGSize()
    var body: some View {
        NavigationStack {
            ZStack {
                ScalingHeaderScrollView {
                    ZStack {
                        FavoriteHeader(
                            searchText: $searchText,
                            selectedType: $selectedType
                        )
                        .saveSize(in: $headerSize)
                    }
                    .background(Material.ultraThinMaterial)
                } content: {
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
                .height(min: headerSize.height, max: headerSize.height)
                .allowsHeaderCollapse()
            }
            .ignoresSafeArea()
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var contentPadView: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                ForEach(0..<6, id: \.self) { index in
                    FavoriteItem()
                        .tag(index)
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
                        .tag(index)
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
