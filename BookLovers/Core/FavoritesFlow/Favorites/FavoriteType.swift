//
//  FavoriteType.swift
//  BookLovers
//
//  Created by Yanis on 13.02.2024.
//

import Foundation

enum FavoriteType: String, CaseIterable, Identifiable {
    case onReading = "On reading"
    case readingList = "Reading list"
    case archived = "Archived"
    
    var id: String { rawValue }
    
    var image: String {
        switch self {
        case .onReading:
            return "book.closed"
        case .readingList:
            return "checklist"
        case .archived:
            return "archivebox"
        }
    }
}
