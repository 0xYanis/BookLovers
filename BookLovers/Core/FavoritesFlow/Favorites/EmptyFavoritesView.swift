//
//  EmptyFavoritesView.swift
//  BookLovers
//
//  Created by Yanis on 20.03.2024.
//

import SwiftUI
import Components

struct EmptyFavoritesView: View {
    @Environment(\.currentTab) var currentTab
    
    var body: some View {
        EmptyScreen(
            title: "heart",
            subtitle: "Add books to favorites",
            systemImage: "You can always have access to your favorites"
        )
        .overlay(alignment: .bottom) {
            BigButton(
                title: "Explore books",
                action: exploreTapped
            )
            .padding(.bottom, 64)
        }
    }
    
    private func exploreTapped() {
        currentTab.wrappedValue = .explore
    }
}
