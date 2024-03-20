//
//  EmptyFavoritesView.swift
//  BookLovers
//
//  Created by Yanis on 20.03.2024.
//

import SwiftUI

struct EmptyFavoritesView: View {
    var body: some View {
        VStack(spacing: 32) {
            Image(systemName: "heart")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.gray)
                .frame(width: 52, height: 52)
            VStack(spacing: 12) {
                Text("Add books to favorites")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("You can always have access to your favorites")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 32)
            }
        }
        .frame(maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            BigButton(title: "Search books", action: {})
        }
        .padding()
    }
}

struct EmptyFavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyFavoritesView()
    }
}
