//
//  UserConfigurator.swift
//  BookLovers
//
//  Created by Yanis on 07.03.2024.
//

import Foundation
import SwiftUI
import FirebaseAuth

final class UserConfigurator {
    private let auth = Auth.auth()
    
    func getCurrentUser() -> User {
        guard let user = auth.currentUser
        else { return .anonymous }
        return User(
            avatar: user.photoURL,
            email: user.email,
            username: user.displayName,
            isAuthenticated: !user.isAnonymous
        )
    }
} 

// MARK: - Init for firebase user

extension User {
    init(
        avatar: URL?,
        email: String?,
        username: String?,
        isAuthenticated: Bool
    ) {
        self.init(
            avatar: avatar,
            email: email ?? "",
            username: username ?? "",
            status: "",
            messages: 0,
            favoriteGenre: .actionAdventure,
            isAuthenticated: isAuthenticated)
    }
}
