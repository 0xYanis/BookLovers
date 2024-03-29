//
//  BookLoversApp.swift
//  BookLovers
//
//  Created by Yanis on 22.01.2024.
//

import SwiftUI
import FirebaseCore

@main
struct BookLoversApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    var delegate
    
    @StateObject
    var userStore = UserStore()
    
    var body: some Scene {
        WindowGroup {
            #if os(macOS)
            HomeView()
            #else
            LaunchView(animated: userStore.showLaunch)
                .preferredColorScheme(colorScheme)
                .environmentObject(userStore)
                .tint(.green)
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
