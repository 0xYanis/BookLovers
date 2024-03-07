//
//  UserStore.swift
//  BookLovers
//
//  Created by Yanis on 17.02.2024.
//

import Foundation
import SwiftUI

final class UserStore: ObservableObject {
    private let userConfig = UserConfigurator()
    @Published var user: User = .anonymous
    
    @AppStorage("Launch") var showLaunch: Bool = false
    @AppStorage("Onboarding") var showOnboarding: Bool = true
    @AppStorage("ColorScheme") var colorScheme: Mode = .system
    
    init() { self.user = userConfig.getCurrentUser() }
    
    // MARK: - User data
    
    func setStatus(isAuthenticated: Bool) {
        self.user.isAuthenticated = isAuthenticated
        if isAuthenticated == false { clearUserData(); return }
        self.user = userConfig.getCurrentUser()
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
    }
}
