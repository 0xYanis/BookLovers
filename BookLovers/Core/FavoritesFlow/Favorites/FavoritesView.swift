//
//  FavoritesView.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI
import Components

struct FavoritesView: View {
    @State private var searchText = ""
    @State private var selectedType: FavoriteType = .onReading
    @State private var requestSignIn = false
    @State private var barState: Visibility = .visible
    @StateObject private var viewModel = FavoriteViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                FavoriteHeader(
                    searchText: $searchText,
                    selectedType: $selectedType,
                    barState: $barState)
                if viewModel.books.isEmpty {
                    EmptyFavoritesView()
                } else {
                    HideBarScrollView(
                        barState: $barState,
                        content: currentContentView
                    )
                }
            }
            .edgesIgnoringSafeArea(.top)
            .toolbar(barState, for: .tabBar)
            .animation(.easeIn(duration: 0.15), value: barState)
        }
    }
    
    // iPad & Mac
    private var gridView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
            ForEach(viewModel.books) { book in
                FavoriteItem(book: book).tag(book.id)
            }
        }
        .padding()
    }
    
    // iPhone
    private var stackView: some View {
        LazyVStack(spacing: 15) {
            ForEach(viewModel.books) { book in
                FavoriteItem(book: book).tag(book.id)
                    .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
    
    @ViewBuilder
    private func currentContentView() -> some View {
        if UIDevice.isiPhone { stackView }
        else { gridView }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
