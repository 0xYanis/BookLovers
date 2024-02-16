//
//  ExploreView.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

struct ExploreView: View {
    @StateObject private var coordinator = ExploreCoordinator()
    @State private var selectedSideOption: MenuOption = .explore
    @State private var showSideMenu = false
    @State private var showSearchView = false
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            MenuContainer(
                isOpened: $showSideMenu,
                menu: menuScreen,
                content: exploreScreen)
            .environmentObject(coordinator)
            .refreshable(action: {})
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: coordinator.path) {
                if $0.isEmpty { selectedSideOption = .explore }
            }
            .navigationDestination(for: MenuOption.self) {
                coordinator.build(page: $0)
            }
            .fullScreenCover(isPresented: $showSearchView, content: SearchView.init)
        }
    }
    
    // MARK: - UI components
    
    private var leadingItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Menu {
                if !showSideMenu { menuLeadingItems }
            } label: {
                Image(systemName: showSideMenu ? "arrow.left" : "list.bullet")
                    .foregroundStyle(showSideMenu ? .gray : .primary)
            } primaryAction: {
                leadingItemAction()
            }
        }
    }
    
    private var menuLeadingItems: some View {
        ForEach(MenuOption.allCases) { option in
            Button {
                coordinator.push(page: option)
            } label: {
                Label(option.title, systemImage: option.image)
            }
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
    
    private func exploreScreen() -> some View {
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
    
    private func menuScreen() -> some View {
        SideMenuView(
            isShowing: $showSideMenu,
            selectedOption: $selectedSideOption)
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
