//
//  User.swift
//  BookLovers
//
//  Created by Yanis on 23.02.2024.
//

import Foundation
import SwiftUI

struct User: Identifiable {
    var id = UUID()
    var avatar: Image
    let email: String
    var username: String
    var status: String
    var messages: Int
    var favoriteGenre: LiteraryGenre
    var isAuthenticated: Bool
    var isDefaultImage: Bool
    
    static let anonymous: User = User(
        avatar: Image(systemName: "person.fill"),
        email: "",
        username: "Anonymous#\(String.randomNum)",
        status: "Hello, Bookly!",
        messages: 0,
        favoriteGenre: LiteraryGenre.allCases.randomElement() ?? .actionAdventure,
        isAuthenticated: false,
        isDefaultImage: true
    )
}

// MARK: - Helpers

private extension String {
    static var randomNum: String {
        String(Int.random(in: 111...999))
    }
}
