//
//  SearchView.swift
//  BookLovers
//
//  Created by Yanis on 07.02.2024.
//

import SwiftUI
import Components

struct SearchView: View {
    @State private var showSearchButton = false
    @State private var showProgressView = false
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 30) {
                        SearchBar("Search books", text: $viewModel.searchText)
                            .id("searchbar")
                            .focused($isFocused)
                            .padding(.horizontal)
                            .onAppear(perform: searchBarAppear)
                            .onDisappear(perform: searchBarDisappear)
                        
                        contentView
                    }
                }
                .overlay(alignment: .bottomTrailing) {
                    searchButton(proxy)
                }
                .overlay {
                    if viewModel.isSearching {
                        ProgressView()
                    }
                }
            }
            .toolbar { trailingButton }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .animation(.easeInOut(duration: 0.3), value: showSearchButton)
        }
        .refreshable { viewModel.refresh() }
        .animation(.spring(), value: viewModel.isSearching)
        .onAppear {
            isFocused = true
            viewModel.startQueryObserve()
        }
        .onDisappear {
            viewModel.cancelSearchObserve()
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        if !viewModel.isSearching {
            HistorySearch(history: viewModel.history) { tappedLabel in
                viewModel.searchText = tappedLabel
            }
        }
        
        if viewModel.books.isEmpty && !viewModel.isSearching {
            EmptySearchView()
                .transition(.opacity)
                .padding(.top, 100)
        } else {
            searchResultsView
                .transition(.opacity)
        }
        
        if showProgressView {
            ProgressView()
                .frame(maxWidth: .infinity)
        }
    }
    
    private var titleView: some View {
        Text("Search")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.horizontal)
    }
    
    private var searchResultsView: some View {
        NewParagraphView(title: "Discover") {
            LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                Section {
                    ForEach(viewModel.books) { book in
                        MostPopularItem(book: book, background: Color.gray.opacity(0.1))
                            .tag(book.id)
                            .padding(.horizontal)
                            .padding(.bottom)
                            .onAppear { appearedItem(book.id) }
                    }
                } header: {
                    TagCaruselView(
                        tags: LiteraryGenre.asArray,
                        onTap: sortByTag
                    )
                    .padding(.vertical, 10)
                    .background()
                }
            }
        } topItem: {
            if !viewModel.books.isEmpty {
                trailingParagraphItem
            }
        }
    }
    
    private var trailingParagraphItem: some View {
        Menu {
            ForEach(SortType.allCases) { type in
                Button {
                    setSortType(type)
                } label: {
                    Label(type.title, systemImage: type.image)
                }
            }
        } label: {
            Group {
                Text("Sort by")
                Image(systemName: "arrow.up.arrow.down")
            }
            .font(.callout)
            .transition(.opacity)
        }
    }
    
    private var trailingButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            XButton(action: dismiss.callAsFunction)
        }
    }
    
    @ViewBuilder
    private func searchButton(_ proxy: ScrollViewProxy) -> some View {
        if showSearchButton {
            Button {
                withAnimation {
                    proxy.scrollTo("searchbar", anchor: .top)
                    isFocused = true
                }
            } label: {
                Image(systemName: "magnifyingglass")
                    .padding(10)
                    .background(Material.bar)
                    .clipShape(Circle())
                    .shadow(radius: 15)
                    .padding()
            }
        }
    }
}

// MARK: - Private logic methods

private extension SearchView {
    func setSortType(_ type: SortType) {
        
    }

    func sortByTag(_ id: Int) {
        
    }
    
    func appearedItem(_ id: String) {
        if id == viewModel.books.last?.id {
            showProgressView = true
            viewModel.loadMore()
        } else {
            showProgressView = false
        }
    }
    
    func searchBarAppear() {
        showSearchButton = false
    }
    
    func searchBarDisappear() {
        showSearchButton = true
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
