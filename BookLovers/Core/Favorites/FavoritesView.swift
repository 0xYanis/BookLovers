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
    @State private var showSearchbar = true
    @State private var headerSize = CGSize()
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScalingHeaderScrollView {
                    FavoriteHeader(
                        searchText: $searchText,
                        selectedType: $selectedType
                    )
                    .saveSize(in: $headerSize)
                } content: {
                    TabView(selection: $selectedType) {
                        ForEach(FavoriteType.allCases) { type in
                            currentContentView.tag(type)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: 130 * 10 + headerSize.height) // 130 = height , 10 = items count
                }
                .height(min: headerSize.height, max: headerSize.height)
                .hideScrollIndicators()
                .allowsHeaderCollapse()
            }
            .ignoresSafeArea()
            .navigationBarTitleDisplayMode(.inline)
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
        LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
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
        }
        .padding(.vertical)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}

struct ScrollViewPagingModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onAppear {
                UIScrollView.appearance().isPagingEnabled = true
            }
            .onDisappear {
                UIScrollView.appearance().isPagingEnabled = false
            }
    }
}

extension ScrollView {
    func enablePagging() -> some View {
        modifier(ScrollViewPagingModifier())
    }
}
