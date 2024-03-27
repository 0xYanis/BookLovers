//
//  SearchViewModel.swift
//  BookLovers
//
//  Created by Yanis on 28.02.2024.
//

import Foundation
import Combine

enum SearchState: String {
    case empty
    case typing
    case loading
    case loaded
    case failed
}

@MainActor
final class SearchViewModel: ObservableObject {
    @Published private(set) var state: SearchState = .empty
    @Published private(set) var history = [String]()
    @Published private(set) var sortedBooks = [Book]()
    @Published var sortType: SortType = .initial
    @Published var searchText = "" {
        didSet {
            if searchText.isEmpty { state = .loaded }
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
        state = .loading
    }
    
    func refresh() {
        guard !searchText.isEmpty else { return }
        state = .loading
        startIndex = 0
        books.removeAll()
        searchInWeb()
    }
    
    func clear() {
        startIndex = 0
        books.removeAll()
        sortedBooks.removeAll()
        searchText.removeAll()
        state = .empty
    }
    
    func bind() {
        $searchText
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map { $0.isEmpty }
            .sink { [weak self] isEmpty in
                guard !isEmpty else { return }
                self?.state = .typing
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
}

// MARK: - Private methods

private extension SearchViewModel {
    func searchInWeb(startIndex: Int = 0) {
        searchRepository
            .search(query: searchText, count: maxResults, startIndex: startIndex)
            .compactMap { $0.items }
            .sink { [unowned self] completion in
                switch completion {
                case .finished:
                    print("FINISHED \n")
                case .failure(let error):
                    self.state = .failed
                    print(error)
                }
            } receiveValue: { [unowned self] list in
                self.show(list: list)
            }
            .store(in: &cancellabels)
    }
    
    func show(list: [DTOBook]) {
        self.state = .loaded
        saveQuery()
        books.append(contentsOf: list.converted)
        updateSortType()
    }
    
    func saveQuery() {
        if history.contains(searchText) { return }
        if history.count >= 3 { history.removeFirst() }
        UserDefaults.standard.set(history, forKey: "History")
        history.insert(searchText, at: 0)
    }
    
    func loadQuery() {
        let ud = UserDefaults.standard
        let savedHistory = ud.object(forKey: "History") as? [String]
        self.history = savedHistory ?? []
    }
    
    func updateSortType() {
        sortedBooks = books
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
