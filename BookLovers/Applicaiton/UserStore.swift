//
//  UserStore.swift
//  BookLovers
//
//  Created by Yanis on 17.02.2024.
//

import Foundation
import SwiftUI

final class UserStore: ObservableObject {
    @Published var user: User = .anonymous
    
    @AppStorage("Launch") var showLaunch: Bool = false
    @AppStorage("Onboarding") var showOnboarding: Bool = true
    @AppStorage("ColorScheme") var colorScheme: Mode = .system
    
    // MARK: - User data
    
    func setStatus(isAuthenticated: Bool) {
        self.user.isAuthenticated = isAuthenticated
        if isAuthenticated == false { clearUserData() }
    }
    
    func setImage(_ image: Image) {
        user.isDefaultImage = false
        user.avatar = image
    }
    
    func updateBadge(count: Int) {
        guard count >= 0 else { return }
        user.messages = count
    }
    
    func clearUserData() {
        user = .anonymous
    }
}
