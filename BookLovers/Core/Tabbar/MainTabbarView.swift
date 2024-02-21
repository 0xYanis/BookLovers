//
//  MainTabbarView.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

struct MainTabbarView: View {
    @State private var selectedTab: TabItem = .explore
    @EnvironmentObject private var userStore: UserStore
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(TabItem.allCases) { item in
                item.view
                    .tag(item)
                    .tabItem {
                        if UIDevice.isiPhone {
                            Image(uiImage: item.uiImage(selected: selectedTab))
                        } else {
                            Image(systemName: item.image)
                        }
                        Text(item.name)
                    }
                    .badge(item == .community ? userStore.messageCount : 0)
            }
        }
        .tint(.green)
    }
}

struct MainTabbarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabbarView()
            .environmentObject(UserStore())
    }
}
