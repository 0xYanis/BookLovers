//
//  MainTabbarView.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

struct MainTabbarView: View {
    @State private var visibility: Visibility = .automatic
    @State private var selectedTab: TabItem = .explore
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(TabItem.allCases) { item in
                item.view
                    .tabItem {
                        Image(uiImage: item.uiImage(selected: selectedTab))
                        Text(item.name)
                    }
                    .badge(item.badgeNumber)
                    .tag(item)
            }
        }
        .toolbar(visibility, for: .tabBar)
    }
}

struct MainTabbarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabbarView()
    }
}
