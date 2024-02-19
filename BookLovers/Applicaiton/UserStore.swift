//
//  UserStore.swift
//  BookLovers
//
//  Created by Yanis on 17.02.2024.
//

import Foundation
import SwiftUI

final class UserStore: ObservableObject {
    @Published var username = "Anonymous #\(String.randomNum)"
    @Published var userStatus = ""
    @Published var userFavoriteGenre: LiteraryGenre = .actionAdventure
    
    @Published private(set) var email: String = ""
    @Published private(set) var messageCount = 0
    @Published private(set) var isAuthenticated = false
    @Published private(set) var image: Image
    @Published private(set) var isDefaultImage = true
    
    init() {
        self.image = Image(systemName: "person.fill")
    }
    
    func setStatus(isAuthenticated: Bool) {
        self.isAuthenticated = isAuthenticated
    }
    
    func setImage(_ image: Image) {
        isDefaultImage = false
        self.image = image
    }
    
    func setEmail(_ email: String) {
        self.email = email
    }
    
    func increaseBadge() {
        self.messageCount += 1
    }
    
    func decreaseBadge() {
        if messageCount > 0 {
            self.messageCount -= 1
        }
    }
    
    func clearUserData() {
        username = "Anonymous #\(String.randomNum)"
        userStatus.removeAll()
        image = Image(systemName: "person.fill")
        isDefaultImage = true
        email.removeAll()
        messageCount = 0
    }
}

// MARK: - Helpers

private extension String {
    static var randomNum: String {
        String(Int.random(in: 111...999))
    }
}
