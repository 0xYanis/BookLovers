//
//  ExploreView.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

struct ExploreView: View {
    @State private var selectedSideOption: MenuOption = .home
    @State private var showSideMenu = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                exploreScreen
                
                if showSideMenu {
                    sideMenuScreen
                        .toolbar(.hidden, for: .tabBar)
                }
            }
        }
    }
    
    private var exploreScreen: some View {
        ScrollView {
            // header
            ExploreHeader()
                .padding()
            // tags
            
            // most popular now
            
            // all books
        }
        .toolbar {
            // 3lines
            leadingItem
            // avatar
            trailingItem
        }
    }
    
    private var sideMenuScreen: some View {
        SideMenuView(
            isShowing: $showSideMenu,
            selectedOption: $selectedSideOption
        )
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
