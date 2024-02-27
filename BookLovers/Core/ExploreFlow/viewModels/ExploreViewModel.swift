//
//  ExploreViewModel.swift
//  BookLovers
//
//  Created by Yanis on 27.02.2024.
//

import Foundation

final class ExploreViewModel: ObservableObject {
    @Published var searchText = ""
    
    func sortSearchResults(by tag: Int) {
        let currentTag = LiteraryGenre.asArray[tag]
    }
    
    func sortSearchResults(by type: SortType) {
        
    }
}
