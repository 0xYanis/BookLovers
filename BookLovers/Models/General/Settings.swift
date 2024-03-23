//
//  Settings.swift
//  BookLovers
//
//  Created by Yanis on 01.03.2024.
//

import Foundation

// MARK: - Color scheme of the Application
enum Mode: String, CaseIterable, Identifiable {
    case system
    case light
    case dark
    
    var id: String { rawValue }
    var title: String { rawValue.capitalized }
}
