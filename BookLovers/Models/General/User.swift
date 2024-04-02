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
    var avatar: URL?
    let email: String
    @MaxLengthString var username: String
    var status: String
    var messages: Int
    var favoriteGenre: LiteraryGenre
    var isAuthenticated: Bool
    
    static let anonymous: User = User(
        avatar: nil,
        email: "",
        username: "Anonymous#\(String.randomNum)",
        status: "Hello, Bookly!",
        messages: 0,
        favoriteGenre: LiteraryGenre.allCases.randomElement() ?? .architecture,
        isAuthenticated: false
    )
}

// MARK: - Helpers

private extension String {
    static var randomNum: String {
        String(Int.random(in: 111...999))
    }
}

@propertyWrapper
struct MaxLengthString {
    private var value: String = ""
    
    var wrappedValue: String {
        get { return value }
        set { if newValue.count <= 22 { value = newValue } }
    }
    
    init(wrappedValue: String) {
        if wrappedValue.count <= 22 {
            self.value = wrappedValue
        }
    }
}
