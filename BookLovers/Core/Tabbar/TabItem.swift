//
//  TabItem.swift
//  BookLovers
//
//  Created by Yanis on 06.02.2024.
//

import SwiftUI

enum TabItem: String, Identifiable, CaseIterable {
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
        case .explore  : ExploreView()
        case .favorites: FavoritesView()
        case .community: CommunityView()
        }
    }
    
    func uiImage(selected: TabItem) -> UIImage {
        UIImage(
            systemName: selected == self ?
            filledImage : image
        ) ?? UIImage()
    }
}
