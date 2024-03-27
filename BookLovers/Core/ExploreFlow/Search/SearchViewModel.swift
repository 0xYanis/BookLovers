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
    @Published private(set) var sortedBooks = [Book]()
    @Published private(set) var isSearching = false
    @Published var sortType: SortType = .initial
    @Published var searchText = "" {
        didSet {
            if searchText.isEmpty { isSearching = false }
        }
    }
    
    private(set) var books = [Book]()
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
        loadQuery()
    }
    
    func loadMore() {
        startIndex += maxResults
        searchInWeb(startIndex: startIndex)
    }
    
    func refresh() {
        guard !searchText.isEmpty else { return }
        isSearching = true
        startIndex = 0
        books.removeAll()
        searchInWeb()
    }
    
    func clear() {
        startIndex = 0
        books.removeAll()
        searchText.removeAll()
    }
    
    func bind() {
        $searchText
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map { $0.isEmpty }
            .sink { [weak self] isEmpty in
                guard !isEmpty else { return }
                self?.refresh()
            }
            .store(in: &cancellabels)
        
        $sortType
            .sink { [unowned self] _ in
                self.updateSortType()
            }
            .store(in: &cancellabels)
    }
    
    func unbind() {
        cancellabels.removeAll()
    }
    
    // MARK: - Private methods
    
    private func searchInWeb(startIndex: Int = 0) {
        searchRepository
            .search(query: searchText, count: maxResults, startIndex: startIndex)
            .compactMap { $0.items }
            .sink { completion in
                switch completion {
                case .finished:
                    print("FINISHED \n")
                case .failure(let error):
                    self.isSearching = false
                    print(error)
                }
            } receiveValue: { [weak self] list in
                self?.show(list: list)
            }
            .store(in: &cancellabels)
    }
    
    private func show(list: [DTOBook]) {
        isSearching = false
        saveQuery()
        books.append(contentsOf: list.converted)
        updateSortType()
    }
    
    private func saveQuery() {
        if history.contains(searchText) { return }
        if history.count >= 3 { history.removeFirst() }
        UserDefaults.standard.set(history, forKey: "History")
        history.insert(searchText, at: 0)
    }
    
    private func loadQuery() {
        let ud = UserDefaults.standard
        let savedHistory = ud.object(forKey: "History") as? [String]
        self.history = savedHistory ?? []
    }
    
    private func updateSortType() {
//        switch sortType {
//        case .alphabetical:
//            sortedBooks = books.sorted { $0.title < $1.title }
//        case .byAuthor:
//            sortedBooks = books.sorted { $0.authors < $1.authors }
//        case .byDate:
//            sortedBooks = books.sorted { $0.publishedDate < $1.publishedDate }
//        case .initial:
//            sortedBooks = books
//        }
    }
}
