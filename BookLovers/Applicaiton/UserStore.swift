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
    @Published var settings = Settings()
    
    init() {
        initialize()
    }
    
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
    
    // MARK: - App data
    
    func setAppearance(mode: Mode) {
        UserDefaults.standard.set(
            mode.title,
            forKey: Keys.appearance.rawValue
        )
    }
    
    func setLaunch(show: Bool) {
        UserDefaults.standard.set(
            show,
            forKey: Keys.launch.rawValue
        )
    }
}

// MARK: - Private methods

private extension UserStore {
    enum Keys: String {
        case appearance, launch
    }
    
    func initialize() {
        getAppearance()
        getLaunchAnimation()
    }
    
    func getAppearance() {
        guard
            let str = UserDefaults.standard.string(
                forKey: Keys.appearance.rawValue),
            let mode = Mode(rawValue: str.lowercased())
        else { return }
        settings.colorScheme = mode
    }
    
    func getLaunchAnimation() {
        let state = UserDefaults.standard.bool(
            forKey: Keys.launch.rawValue
        )
        settings.showLaunch = state
    }
}
