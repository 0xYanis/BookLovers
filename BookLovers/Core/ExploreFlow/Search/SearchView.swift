//
//  SearchView.swift
//  BookLovers
//
//  Created by Yanis on 07.02.2024.
//

import SwiftUI
import Components

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    titleView
                    
                    SearchBar("Search books", text: $viewModel.searchText)
                        .focused($isFocused)
                        .padding(.horizontal)
                    
                    historyView
                    
                    NewParagraphView(title: "Discover") {
                        VStack {
                            TagCaruselView(tags: LiteraryGenre.asArray, onTap: sortByTag)
                            MostPopularItem(background: Color(.tertiarySystemBackground))
                                .frame(height: 150)
                                .padding()
                        }
                    } topItem: {
                        trailingParagraphItem
                    }
                }
            }
            .toolbar(content: leadingItem)
        }
        .onAppear {
            isFocused = true
        }
    }
    
    private func leadingItem() -> some ToolbarContent {
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
    
    private var historyView: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(0..<3, id: \.self) { item in
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding(.horizontal)
                        .foregroundStyle(.secondary)
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
        viewModel.sortSearchResults(by: type)
    }

    private func sortByTag(_ id: Int) {
        viewModel.sortSearchResults(by: id)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
