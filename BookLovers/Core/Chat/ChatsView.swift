//
//  ChatsView.swift
//  BookLovers
//
//  Created by Yanis on 15.02.2024.
//

import SwiftUI

struct ChatsView: View {
    @State private var searchText = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Section {
                    ScrollView(content: contentView)
                } header: {
                    headerView
                }
            }
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    
                } label: {
                    Image("avatar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                }

                Spacer()
                
                ImageButton(systemImage: "plus") {
                    // action
                }
                .imageScale(.small)
                .padding(5)
                .background { Circle().stroke() }
            }
            .overlay {
                Text("Chats")
                    .font(.headline)
            }
            .padding()
            
            searchbar
            
            Divider()
                .padding(.top)
        }
        .background(Material.regular)
    }
    
    private var searchbar: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 5) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
                TextField("Search favorites", text: $searchText)
                    .focused($isFocused)
                Button {
                    searchText.removeAll()
                } label: {
                    Image(systemName: searchText.isEmpty ? "" : "xmark")
                }
                .buttonStyle(.plain)
                .foregroundStyle(.gray)
            }
            .padding(.horizontal, 5)
        }
        .padding(10)
        .background(Color(.systemBackground))
        .clipShape(Capsule())
        .padding(.horizontal)
    }
    
    private func contentView() -> some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<30, id: \.self) { chat in
                    ChatItemView(
                        avatar: "avatar",
                        name: "Yanis",
                        message: "Hello world!",
                        time: Date(),
                        isRead: true)
                }
            }
            .padding()
        }
    }
}

struct ChatsView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsView()
    }
}
