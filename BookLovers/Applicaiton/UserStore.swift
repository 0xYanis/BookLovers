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
