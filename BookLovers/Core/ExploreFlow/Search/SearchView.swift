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
    @Namespace private var animation
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(
                        alignment: .leading,
                        spacing: 0,
                        pinnedViews: .sectionHeaders
                    ) {
                        searchBarView
                        contentView
                    }
                }
                .overlay(alignment: .bottomTrailing) {
                    searchButton(proxy)
                }
            }
            .toolbar { trailingButton }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .animation(.easeInOut(duration: 0.3), value: showSearchButton)
        }
        .refreshable { viewModel.refresh() }
        .animation(.spring(), value: viewModel.state)
        .onAppear {
            isFocused = true
            viewModel.bind()
        }
        .onDisappear {
            viewModel.unbind()
        }
    }
    
    private var searchBarView: some View {
        HStack {
            SearchBar("Search books", text: $viewModel.searchText)
                .focused($isFocused)
                .onAppear(perform: searchBarAppear)
                .onDisappear(perform: searchBarDisappear)
            
            if !viewModel.books.isEmpty {
                Button("Clear", action: clear)
            }
        }
        .id("searchbar")
        .padding()
    }
    
    @ViewBuilder
    private var contentView: some View {
        if viewModel.state != .loading {
            HistorySearch(
                history: viewModel.history,
                perform: historyTapped(_:)
            )
            .padding(.vertical)
        }
        
        if viewModel.state == .empty {
            EmptySearchView()
                .transition(.opacity)
                .padding(.top, 32)
        } else {
            searchResultsView
        }
        
        if viewModel.state == .loading {
            ProgressView()
                .frame(maxWidth: .infinity)
        }
    }
    
    private var searchResultsView: some View {
        NewParagraphView(title: "Discover") {
            TagCaruselView(
                tags: LiteraryGenre.asArray,
                onTap: sortByTag
            )
            .padding(.vertical, 10)
            .background()
            ForEach(viewModel.sortedBooks) { book in
                SearchCardView(book: book, animation: animation)
                    .tag(book.id)
            }
            Color.clear
                .frame(height: 50)
                .onAppear(perform: loadMore)
        } topItem: {
            if !viewModel.books.isEmpty {
                sortByButton
            }
        }
    }
    
    private var sortByButton: some View {
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
                Image(systemName: viewModel.sortType.image)
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
                isFocused = true
                withAnimation {
                    proxy.scrollTo("searchbar", anchor: .top)
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
    func historyTapped(_ history: String) {
        viewModel.searchText = history
    }
    
    func setSortType(_ type: SortType) {
        viewModel.sortType = type
    }

    func sortByTag(_ id: Int) {
        
    }
    
    func loadMore() {
        viewModel.loadMore()
    }
    
    func searchBarAppear() {
        showSearchButton = false
    }
    
    func searchBarDisappear() {
        showSearchButton = true
    }
    
    func clear() {
        viewModel.clear()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
