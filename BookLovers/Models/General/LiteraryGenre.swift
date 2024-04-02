//
//  LiteraryGenre.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import Foundation

enum LiteraryGenre: String, CaseIterable, Identifiable {
    case antiquesAndCollectibles = "antiques & collectibles"
    case literaryCollections = "literary collections"
    case architecture
    case literaryCriticism = "literary criticism"
    case art
    case mathematics
    case bibles
    case medical
    case biographyAndAutobiography = "biography & autobiography"
    case music
    case bodyMindAndSpirit = "body, mind & spirit"
    case nature
    case businessAndEconomics = "business & economics"
    case performingArts = "performing arts"
    case comicsAndGraphicNovels = "comics & graphic novels"
    case pets
    case computers
    case philosophy
    case cooking
    case photography
    case craftsAndHobbies = "crafts & hobbies"
    case poetry
    case design
    case politicalScience = "political science"
    case drama
    case psychology
    case education
    case reference
    case familyAndRelationships = "family & relationships"
    case religion
    case fiction
    case science
    case foreignLanguageStudy = "foreign language study"
    case self_help = "self-help"
    case gamesAndActivities = "games & activities"
    case socialScience = "social science"
    case gardening
    case sportsAndRecreation = "sports & recreation"
    case healthAndFitness = "health & fitness"
    case studyAids = "study aids"
    case history
    case technologyAndEngineering = "technology & engineering"
    case houseAndHome = "house & home"
    case transportation
    case humor
    case travel
    case juvenileFiction = "juvenile fiction"
    case trueCrime = "true crime"
    case juvenileNonfiction = "juvenile nonfiction"
    case youngAdultFiction = "young adult fiction"
    case languageArtsAndDisciplines = "language arts & disciplines"
    case youngAdultNonfiction = "young adult nonfiction"
    case law
    
    static var asArray: [String] { LiteraryGenre.allCases.map { $0.title } }
    
    var id: String { rawValue }
    var title: String { rawValue.capitalized }
    var image: String {
        switch self {
        case .antiquesAndCollectibles:
            return ""
        case .literaryCollections:
            return ""
        case .architecture:
            return ""
        case .literaryCriticism:
            return ""
        case .art:
            return ""
        case .mathematics:
            return ""
        case .bibles:
            return ""
        case .medical:
            return ""
        case .biographyAndAutobiography:
            return ""
        case .music:
            return ""
        case .bodyMindAndSpirit:
            return ""
        case .nature:
            return ""
        case .businessAndEconomics:
            return ""
        case .performingArts:
            return ""
        case .comicsAndGraphicNovels:
            return ""
        case .pets:
            return ""
        case .computers:
            return ""
        case .philosophy:
            return ""
        case .cooking:
            return ""
        case .photography:
            return ""
        case .craftsAndHobbies:
            return ""
        case .poetry:
            return ""
        case .design:
            return ""
        case .politicalScience:
            return ""
        case .drama:
            return ""
        case .psychology:
            return ""
        case .education:
            return ""
        case .reference:
            return ""
        case .familyAndRelationships:
            return ""
        case .religion:
            return ""
        case .fiction:
            return ""
        case .science:
            return ""
        case .foreignLanguageStudy:
            return ""
        case .self_help:
            return ""
        case .gamesAndActivities:
            return ""
        case .socialScience:
            return ""
        case .gardening:
            return ""
        case .sportsAndRecreation:
            return ""
        case .healthAndFitness:
            return ""
        case .studyAids:
            return ""
        case .history:
            return ""
        case .technologyAndEngineering:
            return ""
        case .houseAndHome:
            return ""
        case .transportation:
            return ""
        case .humor:
            return ""
        case .travel:
            return ""
        case .juvenileFiction:
            return ""
        case .trueCrime:
            return ""
        case .juvenileNonfiction:
            return ""
        case .youngAdultFiction:
            return ""
        case .languageArtsAndDisciplines:
            return ""
        case .youngAdultNonfiction:
            return ""
        case .law:
            return ""
        }
    }
}
