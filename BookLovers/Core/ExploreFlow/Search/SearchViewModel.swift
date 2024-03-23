//
//  SearchViewModel.swift
//  BookLovers
//
//  Created by Yanis on 28.02.2024.
//

import Foundation
import Combine

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var isSearching = false
    @Published var searchText = "" {
        didSet {
            if searchText.isEmpty { isSearching = false }
        }
    }
    
    private var searchRepository: SearchRepository
    private var cancellabels: Set<AnyCancellable> = []
    
    init(
        searchRepository: SearchRepository = SearchRepositoryImpl(
            session: .init(configuration: .default),
            baseURL: "https://www.googleapis.com/books/v1")
    ) {
        self.searchRepository = searchRepository
    }
    
    func startQueryObserve() {
        $searchText
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                if query.isEmpty {
                    return
                } else {
                    self?.isSearching = true
                    self?.searchRepo()
                }
            }
            .store(in: &cancellabels)
    }
    
    private func searchRepo() {
        searchRepository
            .search(query: searchText)
            .sink { _ in
                
            } receiveValue: { list in
                print(list.items.count)
            }
            .store(in: &cancellabels)
    }
    
    func cancelSearchObserve() {
        cancellabels.removeAll()
    }
}
