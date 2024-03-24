//
//  EmptySearchView.swift
//  BookLovers
//
//  Created by Yanis on 24.03.2024.
//

import SwiftUI
import Components

struct EmptySearchView: View {
    var body: some View {
        EmptyScreen(
            title: "Start typing into the search field",
            subtitle: "Bookly's biggest library is at your service",
            systemImage: "magnifyingglass"
        )
    }
}
