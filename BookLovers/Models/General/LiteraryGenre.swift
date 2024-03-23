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
    
    static var asArray: [String] { LiteraryGenre.allCases.map { $0.title } }
    
    var id: String { rawValue }
    var title: String { rawValue.capitalized }
    var image: String {
        switch self {
        case .actionAdventure:
            return "mountain.2"
        case .biography:
            return "person.icloud"
        case .childrenLiterature:
            return "heart.circle.fill"
        case .comedy:
            return "theatermasks"
        case .crimeFiction:
            return "touchid"
        case .drama:
            return "heart.slash"
        case .epic:
            return "figure.baseball"
        case .fantasy:
            return "sun.dust"
        case .historicalFiction:
            return "hourglass"
        case .horror:
            return "18.square"
        case .literaryFiction:
            return "book"
        case .mystery:
            return "bonjour"
        case .nonFiction:
            return "tree"
        case .romance:
            return "heart"
        case .scienceFiction:
            return "atom"
        case .thriller:
            return "bolt"
        case .western:
            return "figure.equestrian.sports"
        }
    }
}
