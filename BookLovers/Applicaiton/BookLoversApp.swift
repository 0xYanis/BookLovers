//
//  BookLoversApp.swift
//  BookLovers
//
//  Created by Yanis on 22.01.2024.
//

import SwiftUI

@main
struct BookLoversApp: App {
    @StateObject private var userStore = UserStore()
    
    var body: some Scene {
        WindowGroup {
            #if os(macOS)
            HomeView()
            #else
            LaunchView(animated: userStore.showLaunch)
                .preferredColorScheme(colorScheme)
                .environmentObject(userStore)
            #endif
        }
    }
    
    private var colorScheme: ColorScheme? {
        switch userStore.colorScheme {
        case .system:
            return .none
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
