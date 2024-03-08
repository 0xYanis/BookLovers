//
//  ExploreHeader.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI
import Components

struct ExploreHeader: View {
    @EnvironmentObject private var userStore: UserStore
    @Binding var showSearchView: Bool
    
    @State private var searchText = ""
    @State private var placeholder = "books"
    @State private var counter = 0
    private let timer = Timer.publish(
        every: 2,
        on: .main,
        in: .common
    ).autoconnect()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading,  spacing: 15) {
                helloLabel
                messageLabel
                TagCaruselView(
                    tags: LiteraryGenre.asArray,
                    onTap: tagTapped(_:)
                )
            }
            SearchBar("Search \(placeholder)", text: $searchText, isActive: false)
                .onTapGesture { showSearchView.toggle() }
                .buttonStyle(.plain)
                .padding(.horizontal)
        }
        .background(Color(.systemBackground))
        .onReceive(timer) { _ in
            if counter == LiteraryGenre.asArray.count {
                counter = 0
            }
            self.placeholder = LiteraryGenre.asArray[counter]
            counter += 1
        }
    }
    
    private var helloLabel: some View {
        Text("Hello, \(userStore.user.username.isEmpty ? userStore.user.username : userStore.user.username.capitalized)")
            .font(.subheadline)
            .padding(.horizontal)
            .padding(.vertical, 10)
    }
    
    private var messageLabel: some View {
        Text("What are you looking for \ntoday?")
            .font(.title2)
            .fontWeight(.semibold)
            .padding(.horizontal)
    }
    
    private func tagTapped(_ id: Int) {
        
    }
}

struct ExploreHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ExploreView()
        }
    }
}
