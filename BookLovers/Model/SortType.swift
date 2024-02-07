//
//  SortType.swift
//  BookLovers
//
//  Created by Yanis on 07.02.2024.
//

import Foundation

enum SortType: String, CaseIterable, Identifiable {
    case ascending
    case descending
    case popularity
    case rating
    
    var id: String { rawValue }
    var title: String { rawValue.capitalized }
    var image: String {
        switch self {
        case .ascending:
            return "arrow.up"
        case .descending:
            return "arrow.down"
        case .popularity:
            return "star.bubble"
        case .rating:
            return "list.number"
        }
    }
}
