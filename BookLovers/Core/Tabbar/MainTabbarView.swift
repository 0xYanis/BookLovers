//
//  MainTabbarView.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

fileprivate enum TabItem: String, Identifiable, CaseIterable {
    case explore
    case favorites
    case community
    
    var id: String { rawValue }
    var name: String { rawValue }
    var image: String {
        switch self {
        case .explore  : return "magnifyingglass"
        case .favorites: return "heart"
        case .community: return "person.3"
        }
    }
    
    var filledImage: String {
        guard self != .explore else { return image }
        return "\(image).fill"
    }
    
    var badgeNumber: Int {
        switch self {
        case .explore  : return 0
        case .favorites: return 0
        case .community: return 4
        }
    }
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .explore  : Text("Explore")
        case .favorites: Text("Favorites")
        case .community: Text("Community")
        }
    }
    
    func uiImage(selected: TabItem) -> UIImage {
        UIImage(
            systemName: selected == self ?
            filledImage : image
        ) ?? UIImage()
    }
}

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
