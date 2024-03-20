//
//  FavoriteViewModel.swift
//  BookLovers
//
//  Created by Yanis on 20.03.2024.
//

import Foundation

@MainActor
final class FavoriteViewModel: ObservableObject {
    @Published var books = [FavoriteBook]()
}
