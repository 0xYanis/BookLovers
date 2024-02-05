//
//  LiteraryGenre.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import Foundation

enum LiteraryGenre: String, CaseIterable, Identifiable {
    case actionAdventure  = "Action Adventure"
    case biography
    case childrenLiterature = "Children Literature"
    case comedy
    case crimeFiction = "Crime Fiction"
    case drama
    case epic
    case fantasy
    case historicalFiction = "Historical Fiction"
    case horror
    case literaryFiction = "Literary Fiction"
    case mystery
    case nonFiction = "Non Fiction"
    case romance
    case scienceFiction = "Science Fiction"
    case thriller
    case western
    
    var id: String { rawValue }
    var title: String { rawValue.capitalized }
}
