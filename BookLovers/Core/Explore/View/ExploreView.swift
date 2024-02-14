//
//  ExploreView.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

struct ExploreView: View {
    @State private var selectedSideOption: MenuOption = .explore
    @State private var showSideMenu = false
    @State private var showSearchView = false
    
    var body: some View {
        NavigationStack {
            MenuContainer(isOpened: $showSideMenu) {
                menuScreen
            } content: {
                exploreScreen
            }
            .refreshable(action: {})
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $showSearchView) {
                SearchView()
            }
        }
    }
    
    private var exploreScreen: some View {
        ScrollView {
            // header
            LazyVStack(spacing: 0) {
                ExploreHeader(showSearchView: $showSearchView)
                    .padding(.bottom)
                
                LazyVStack(spacing: 0) {
                    // most popular now
                    NewParagraphView(title: "Most Popular") {
                        TabView {
                            ForEach(0..<3, id: \.self) { item in
                                MostPopularItem()
                                    .padding(.horizontal)
                            }
                        }
                        .frame(height: 150)
                        .tabViewStyle(.page(indexDisplayMode: .never))
                    } topItem: {
                        Button("View all", action: {})
                            .foregroundStyle(.secondary)
                    }
                    
                    // all books
                    Divider().padding(.horizontal)
                    NewParagraphView(title: "Trending Books") {
                        
                    }
                }
                .padding(.top)
                .frame(maxWidth: .infinity)
                .background(Color(uiColor: .secondarySystemBackground))
                .clipShape(CustomCornersShape(
                    corners: [.topLeft, .topRight],
                    radius: 15)
                )
            }
        }
        .toolbar {
            leadingItem
            centerItem
            trailingItem
        }
    }
    
    // MARK: - UI components
    
    private var menuScreen: some View {
        SideMenuView(
            isShowing: $showSideMenu,
            selectedOption: $selectedSideOption)
    }
    
    private var leadingItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: leadingItemAction) {
                Image(systemName: showSideMenu ? "arrow.left" : "list.bullet")
                    .foregroundStyle(showSideMenu ? .gray : .primary)
            }
            .buttonStyle(.plain)
        }
    }
    
    private var centerItem: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Image(showSideMenu ? "" : "logo-small")
                .resizable()
                .scaledToFill()
                .frame(width: 30, height: 30)
                .scaleByTap(scale: 0.5)
        }
    }
    
    private var trailingItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: trailingItemAction) {
                Image("avatar")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 27)
                    .clipShape(Circle())
            }
        }
    }
    
    // MARK: - Actions
    
    private func leadingItemAction() {
        withAnimation(.spring(dampingFraction: 0.95)) {
            showSideMenu.toggle()
        }
    }
    
    private func trailingItemAction() {
        
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
