//
//  MenuOption.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import Foundation

enum MenuOption: String, Identifiable, CaseIterable {
    case explore
    case profile
    case communities
    case privacyPolicy = "Privacy Policy"
    case support
    case aboutUs = "About Us"
    
    var id: String { return rawValue }
    var title: String { rawValue.capitalized }
    
    var image: String {
        switch self {
        case .explore:
            return "doc.text.magnifyingglass"
        case .profile:
            return "person.text.rectangle"
        case .communities:
            return "person.3.sequence"
        case .privacyPolicy:
            return "shield.lefthalf.filled"
        case .support:
            return "questionmark.bubble"
        case .aboutUs:
            return "books.vertical"
        }
    }
}
