//
//  UserStore.swift
//  BookLovers
//
//  Created by Yanis on 17.02.2024.
//

import Foundation
import SwiftUI

final class UserStore: ObservableObject {
    @Published private(set) var isAuthenticated = false
    @Published private(set) var username = "Anonymous #\(String.randomNum)"
    @Published private(set) var uiImage = UIImage.defaultAvatar
    @Published private(set) var email: String = ""
    @Published private(set) var messageCount = 0
    
    func setStatus(isAuthenticated: Bool) {
        self.isAuthenticated = isAuthenticated
    }
    
    func setName(username: String) {
        self.username = username
    }
    
    func setImage(_ uiImage: UIImage) {
        self.uiImage = uiImage
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
}

// MARK: - Helpers

private extension UIImage {
    static var defaultAvatar: UIImage {
        UIImage(systemName: "person.fill") ?? UIImage()
    }
}

private extension String {
    static var randomNum: String {
        String(Int.random(in: 111...999))
    }
}
