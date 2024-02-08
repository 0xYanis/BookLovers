//
//  FavoritesView.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

struct FavoritesView: View {
    @State private var requestSignIn = false
    var body: some View {
        NavigationStack {
            SignInView(
                type: .favorites,
                requestSignIn: $requestSignIn
            )
        }
    }
}
