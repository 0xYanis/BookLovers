//
//  FavoriteViewModel.swift
//  BookLovers
//
//  Created by Yanis on 20.03.2024.
//

import Foundation
import Combine

@MainActor
final class FavoriteViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedType: FavoriteType = .onReading
    @Published var booksByType = [FavoriteBook]()
    private(set) var allBooks = [FavoriteBook]()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        allBooks = FavoriteBook.preview // debug
        
        sortObserve()
    }
    
    private func sortObserve() {
        $selectedType
            .combineLatest($searchText)
            .map { selectedType, searchText in
                self.allBooks.filter { book in
                    if selectedType != .all && book.type != selectedType {
                        return false
                    }
                    if !searchText.isEmpty && !book.title.localizedCaseInsensitiveContains(searchText) {
                        return false
                    }
                    return true
                }
            }
            .assign(to: &$booksByType)
    }
}
