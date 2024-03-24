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
    @Published private(set) var history = [String]()
    @Published private(set) var books = [Book]()
    @Published private(set) var isSearching = false
    @Published var searchText = "" {
        didSet {
            if searchText.isEmpty { isSearching = false }
        }
    }
    
    private var startIndex: Int = 0
    private var maxResults: Int = 20
    private var searchRepository: SearchRepository
    private var cancellabels: Set<AnyCancellable> = []
    
    init(
        searchRepository: SearchRepository = SearchRepositoryImpl(
            session: .init(configuration: .default),
            baseURL: "https://www.googleapis.com/books/v1")
    ) {
        self.searchRepository = searchRepository
    }
    
    func loadMore() {
        startIndex += maxResults
        searchInWeb(startIndex: startIndex)
    }
    
    func refresh() {
        startIndex = 0
        books.removeAll()
        searchInWeb()
    }
    
    func startQueryObserve() {
        $searchText
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map { $0.isEmpty }
            .sink { [weak self] isEmpty in
                guard !isEmpty else { return }
                self?.isSearching = true
                self?.refresh()
            }
            .store(in: &cancellabels)
    }
    
    func cancelSearchObserve() {
        cancellabels.removeAll()
    }
    
    // MARK: - Private methods
    
    private func searchInWeb(startIndex: Int = 0) {
        searchRepository
            .search(query: searchText, count: maxResults, startIndex: startIndex)
            .sink { completion in
                switch completion {
                case .finished:
                    print("FINISHED \n")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] list in
                self?.show(list: list)
            }
            .store(in: &cancellabels)
    }
    
    private func show(list: DTOBookList) {
        saveQuery()
        books.append(contentsOf: list.items.converted)
    }
    
    private func saveQuery() {
        if history.count >= 3 { history.removeFirst() }
        UserDefaults.standard.set(history, forKey: "History")
        history.append(searchText)
    }
}
