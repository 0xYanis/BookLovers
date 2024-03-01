//
//  Settings.swift
//  BookLovers
//
//  Created by Yanis on 01.03.2024.
//

import Foundation

struct Settings: Identifiable {
    var id = UUID()
    var colorScheme: Mode = .system
    var showLaunch: Bool = true
    var seenOnboarding: Bool = false
}

// MARK: - Color scheme of the Application
enum Mode: String, CaseIterable, Identifiable {
    case system
    case light
    case dark
    
    var id: String { rawValue }
    var title: String { rawValue.capitalized }
}
