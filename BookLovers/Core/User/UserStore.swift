//
//  UserStore.swift
//  BookLovers
//
//  Created by Yanis on 17.02.2024.
//

import Foundation
import SwiftUI

final class UserStore: ObservableObject {
    @AppStorage("Launch") var showLaunch: Bool = false
    @AppStorage("Onboarding") var showOnboarding: Bool = true
    @AppStorage("ColorScheme") var colorScheme: Mode = .system
    
    @Published var user: User = .anonymous
    
    private let userWorker: UserWorkerProtocol
    
    init(userWorker: UserWorkerProtocol = UserWorker()) {
        self.userWorker = userWorker
        self.user = userWorker.currentUser
    }
    
    // MARK: - User data
    
    func setName(_ name: String) {
        userWorker.changeName(name)
        user.username = name
    }
    
    func setAvatar(_ data: Data) {
        Task {
            let url = await userWorker.changeAvatar(data)
            await MainActor.run { user.avatar = url }
        }
    }
    
    func loadAvatar() {
        Task {
            let url = await userWorker.getAvatarUrl()
            await MainActor.run { user.avatar = url }
        }
    }
    
    func setStatus(isAuthenticated: Bool) {
        self.user.isAuthenticated = isAuthenticated
        if isAuthenticated == false { clearUserData(); return }
        self.user = userWorker.currentUser
    }
    
    func updateBadge(count: Int) {
        guard count >= 0 else { return }
        user.messages = count
    }
    
    func clearUserData() {
        userWorker.logout()
        user = .anonymous
    }
    
    func deleteAccount() {
        user = .anonymous
        userWorker.delete()
    }
}

// MARK: - Init (Firebase.User to User)

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
            favoriteGenre: .art,
            isAuthenticated: isAuthenticated)
    }
}
