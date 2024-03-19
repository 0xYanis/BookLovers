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
    
    var body: some View {
        NavigationStack {
            HideBarScrollView(showIndicator: false, barState: $barState) {
                LazyVStack(pinnedViews: .sectionHeaders) {
                    Section(content: {
                        TabView(selection: $selectedType) {
                            ForEach(FavoriteType.allCases) { type in
                                currentContentView.tag(type)
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .frame(height: 130 * 10) // 130 = height , 10 = items count
                    }, header: sectionHeader)
                }
            }
            .edgesIgnoringSafeArea(.top)
            .toolbar(barState, for: .tabBar)
            .animation(.easeIn(duration: 0.2), value: barState)
        }
    }
    
    @ViewBuilder
    private var currentContentView: some View {
        if UIDevice.isiPhone {
            contentView
        } else {
            contentGridView
        }
    }
    
    private var contentGridView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
            ForEach(0..<10, id: \.self) { index in
                FavoriteItem()
                    .tag(index)
                    .onChange(of: index) { newValue in
                        // TODO:
                    }
            }
        }
        .padding()
    }
    
    private var contentView: some View {
        LazyVStack(spacing: 15) {
            ForEach(0..<10, id: \.self) { index in
                FavoriteItem()
                    .tag(index)
                    .padding(.horizontal)
                    .onChange(of: index) { newValue in
                        // TODO:
                    }
            }
            Spacer().frame(height: 120)
        }
        .padding(.vertical)
    }
    
    @ViewBuilder
    private func sectionHeader() -> some View {
        FavoriteHeader(
            searchText: $searchText,
            selectedType: $selectedType,
            barState: $barState
        )
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
