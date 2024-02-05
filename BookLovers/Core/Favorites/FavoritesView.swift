//
//  FavoritesView.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

struct FavoritesView: View {
    @State private var signIn = false
    
    var body: some View {
        NavigationStack {
            SignInView(
                title: "Favorites",
                subtitle: "To see, append and edit favorite books \nyou need to sign in.",
                requestSignIn: $signIn)
        }
    }
}
