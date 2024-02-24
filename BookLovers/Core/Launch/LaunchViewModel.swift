//
//  LaunchViewModel.swift
//  BookLovers
//
//  Created by Yanis on 24.02.2024.
//

import Foundation
import WelcomeSheet

class LaunchViewModel: ObservableObject {
    @Published var showWelcomeSheet = false
    
    private(set) var pages: [WelcomeSheetPage] = [
        WelcomeSheetPage(title: "Bookly: Your literary world", rows: [
            WelcomeSheetPageRow(
                imageSystemName: "globe.americas",
                title: "Endless variety of books",
                content: "Our collection will give you access to the best of world literature, as well as new releases and hidden gems."),
            WelcomeSheetPageRow(
                imageSystemName: "books.vertical",
                title: "Personal Library",
                content: "Save your favorite books in your personal library so you can always access them."),
            WelcomeSheetPageRow(
                imageSystemName: "bubble.left.and.bubble.right",
                title: "Chats and Communities",
                content: "Find new friends and literary like-minded people to inspire each other to read and discuss books.")
        ])
    ]
    
    func checkOnboarding() {
        if UserDefaults.standard.bool(forKey: "SeenOnboarding") { return }
        showWelcomeSheet = true
        UserDefaults.standard.set(showWelcomeSheet, forKey: "SeenOnboarding")
    }
}
