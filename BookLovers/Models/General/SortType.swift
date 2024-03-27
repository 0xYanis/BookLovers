//
//  SortType.swift
//  BookLovers
//
//  Created by Yanis on 07.02.2024.
//

import Foundation

enum SortType: String, CaseIterable, Identifiable {
    case alphabetical
    case byAuthor = "by auhtor"
    case byDate = "by date"
    case initial
    
    var id: String { rawValue }
    var title: String { rawValue.capitalized }
    var image: String {
        switch self {
        case .alphabetical:
            return "textformat.abc"
        case .byAuthor:
            return "person"
        case .byDate:
            return "calendar"
        case .initial:
            return "textformat.123"
        }
    }
}
