//
//  ExploreView.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI
import Components

struct ExploreView: View {
    @State private var selectedSideOption: MenuOption = .explore
    @State private var showSideMenu = false
    @State private var showSearchView = false
    @State private var splitVisibility: NavigationSplitViewVisibility = .doubleColumn
    @State private var path = NavigationPath()
    @EnvironmentObject private var userStore: UserStore
    
    var body: some View {
        #if os(iOS)
        NavigationStack(path: $path) {
            MenuContainer(isOpened: $showSideMenu, menu: menuScreen, content: exploreScreen)
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(for: MenuOption.self, destination: currentView(selected:))
                .fullScreenCover(isPresented: $showSearchView, content: SearchView.init)
                .toolbarBackground(Material.ultraThickMaterial)
        }
        #else
        NavigationSplitView(columnVisibility: $splitVisibility) {
            SideMenuView(isShowing: .constant(true), selectedOption: $selectedSideOption)
        } detail: {
            currentView(selected: selectedSideOption)
        }
        .navigationSplitViewStyle(.balanced)
        .environmentObject(coordinator)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: MenuOption.self, destination: currentView(selected:))
        .fullScreenCover(isPresented: $showSearchView, content: SearchView.init)
        #endif
    }
    
    // MARK: - UI components
    
    private var leadingItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            if UIDevice.isiPhone {
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
    }
    
    private var menuLeadingItems: some View {
        ForEach(MenuOption.allCases) { option in
            Button {
                path.append(option)
            } label: {
                Label(option.title, systemImage: option.image)
            }
        }
    }
    
    private var centerItem: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            if showSideMenu == false {
                Image("logo-small")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30, height: 30)
                    .scaleByTap(scale: 0.5)
                    .transition(.opacity)
                    .animation(.easeIn, value: showSideMenu)
            }
        }
    }
    
    private var trailingItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: trailingItemAction) {
                Avatar(url: userStore.user.avatar)
                    .scaledToFill()
                    .frame(width: 22, height: 22)
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
                                MostPopularItem(background: Color(.systemBackground))
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
        .onDisappear {
            selectedSideOption = .explore
        }
    }
    
    private func menuScreen() -> some View {
        SideMenuView(
            isShowing: $showSideMenu,
            selectedOption: $selectedSideOption,
            navigationPath: $path
        )
    }
    
    // MARK: - Actions
    
    private func leadingItemAction() {
        withAnimation { showSideMenu.toggle() }
    }
    
    private func trailingItemAction() {
        path.append(MenuOption.profile)
    }
    
    @ViewBuilder
    private func currentView(selected: MenuOption) -> some View {
        switch selected {
        case .explore:
            exploreScreen()
        case .profile:
            ProfileView()
        case .communities:
            CommunityListView()
        case .privacyPolicy:
            Text(selected.title)
        case .support:
            Text(selected.title)
        case .aboutUs:
            AboutUsView()
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
            .environmentObject(UserStore())
    }
}
