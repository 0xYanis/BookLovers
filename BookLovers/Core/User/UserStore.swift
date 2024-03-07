//
//  UserStore.swift
//  BookLovers
//
//  Created by Yanis on 17.02.2024.
//

import Foundation
import SwiftUI
import FirebaseAuth

final class UserStore: ObservableObject {
    @AppStorage("Launch") var showLaunch: Bool = false
    @AppStorage("Onboarding") var showOnboarding: Bool = true
    @AppStorage("ColorScheme") var colorScheme: Mode = .system
    
    @Published var user: User = .anonymous
    private let auth = Auth.auth()
    
    init() { self.user = getCurrentUser() }
    
    // MARK: - User data
    
    func setName(_ name: String) {
        user.username = name
        changeName(name)
    }
    
    func setAvatar(_ photoUrl: URL) {
        user.avatar = photoUrl
        changeAvatar(photoUrl)
    }
    
    func setStatus(isAuthenticated: Bool) {
        self.user.isAuthenticated = isAuthenticated
        if isAuthenticated == false { clearUserData(); return }
        self.user = getCurrentUser()
    }
    
    func setImage(imageUrl: URL?) {
        user.avatar = imageUrl
    }
    
    func updateBadge(count: Int) {
        guard count >= 0 else { return }
        user.messages = count
    }
    
    func clearUserData() {
        user = .anonymous
        do {
            try logout()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteAccount() {
        user = .anonymous
        if let user = auth.currentUser {
            Task {
                try? await user.delete()
            }
        }
    }
}

// MARK: - Private methods

private extension UserStore {
    func getCurrentUser() -> User {
        guard let user = auth.currentUser
        else { return .anonymous }
        let displayName = (user.displayName != nil) ? user.displayName : user.email?.emailToName()
        return User(
            avatar: user.photoURL,
            email: user.email,
            username: displayName,
            isAuthenticated: !user.isAnonymous
        )
    }
    
    func changeName(_ name: String) {
        let request = auth.currentUser?.createProfileChangeRequest()
        request?.displayName = name
    }
    
    func changeAvatar(_ photoUrl: URL) {
        let request = auth.currentUser?.createProfileChangeRequest()
        request?.photoURL = photoUrl
    }
    
    func logout() throws {
        try auth.signOut()
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
