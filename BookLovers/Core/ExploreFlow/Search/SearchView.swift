//
//  SearchView.swift
//  BookLovers
//
//  Created by Yanis on 07.02.2024.
//

import SwiftUI
import Components

struct SearchView: View {
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 30) {
                    //titleView
                    
                    SearchBar("Search books", text: $viewModel.searchText)
                        .focused($isFocused)
                        .padding(.horizontal)
                    
                    historyView
                    
                    NewParagraphView(title: "Discover") {
                        LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                            Section {
                                ForEach(viewModel.books) { book in
                                    MostPopularItem(book: book)
                                        .frame(height: 150)
                                        .padding(.horizontal)
                                        .padding(.bottom)
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
                        trailingParagraphItem
                    }
                }
            }
            .toolbar(content: trailingButton)
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
        .animation(.spring(), value: viewModel.isSearching)
        .onAppear {
            isFocused = true
            viewModel.startQueryObserve()
        }
        .onDisappear {
            viewModel.cancelSearchObserve()
        }
    }
    
    private func trailingButton() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            XButton(action: dismiss.callAsFunction)
        }
    }
    
    private var titleView: some View {
        Text("Search")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.horizontal)
    }
    
    @ViewBuilder
    private var historyView: some View {
        if viewModel.isSearching == false {
            VStack(alignment: .leading, spacing: 15) {
                ForEach(0..<3, id: \.self) { item in
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .padding(.horizontal)
                            .foregroundStyle(.gray)
                        Text("The Witcher")
                        Spacer()
                        Image(systemName: "clock.arrow.circlepath")
                    }
                    .font(.callout)
                    Divider()
                }
            }
            .padding()
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
        }
    }
    
    private func setSortType(_ type: SortType) {
        
    }

    private func sortByTag(_ id: Int) {
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
