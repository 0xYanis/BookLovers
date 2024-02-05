//
//  MenuOption.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import Foundation

enum MenuOption: String, Identifiable, CaseIterable {
    case home
    case dashboard
    case profile
    case search
    case notifications
    
    var id: Int {
        switch self {
        case .home:
            return 0
        case .dashboard:
            return 1
        case .profile:
            return 2
        case .search:
            return 3
        case .notifications:
            return 4
        }
    }
    var title: String { rawValue.capitalized }
    
    var systemImageName: String {
        switch self {
        case .home:
            return "house"
        case .dashboard:
            return "chart.bar"
        case .profile:
            return "person"
        case .search:
            return "magnifyingglass"
        case .notifications:
            return "bell"
        }
    }
}
