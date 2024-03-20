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
    @Namespace var animation
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                FavoriteHeader(
                    searchText: $searchText,
                    selectedType: $selectedType,
                    barState: $barState)
                HideBarScrollView(
                    barState: $barState,
                    content: currentContentView
                )
            }
            .edgesIgnoringSafeArea(.top)
            .toolbar(barState, for: .tabBar)
            .animation(.easeIn(duration: 0.15), value: barState)
        }
    }
    
    // iPad & Mac
    private var gridView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
            ForEach(0..<10, id: \.self) { index in
                FavoriteItem().tag(index)
            }
        }
        .padding()
    }
    
    // iPhone
    private var stackView: some View {
        LazyVStack(spacing: 15) {
            ForEach(0..<10, id: \.self) { index in
                FavoriteItem().tag(index)
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
