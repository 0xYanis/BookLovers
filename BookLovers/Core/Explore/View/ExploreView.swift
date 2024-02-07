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
    
    var body: some View {
        NavigationStack {
            MenuContainer(isOpened: $showSideMenu) {
                menuScreen
            } content: {
                exploreScreen
            }
        }
    }
    
    private var exploreScreen: some View {
        ScrollView {
            // header
            ExploreHeader()
                .padding(.vertical, 8)
            
            LazyVStack {
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
                    Button("View all") {
                        
                    }
                    .foregroundStyle(.secondary)
                }

                // all books
                
                Divider().padding(.horizontal)
                
                NewParagraphView(title: "Trending Books") {
                    TrendingBooksGridView()
                        .padding(.horizontal)
                }
            }
            .padding(.top)
            .frame(maxWidth: .infinity)
            .background(Color(uiColor: .secondarySystemBackground))
            .clipShape(CustomCornersShape(
                corners: [.topLeft, .topRight],
                radius: 15))
        }
        .toolbar {
            leadingItem
            trailingItem
        }
    }
    
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
    
    private var trailingItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: trailingItemAction) {
                Image("avatar")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30)
                    .clipShape(Circle())
            }
        }
    }
    
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
