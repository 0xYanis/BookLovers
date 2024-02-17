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
            LaunchView()
                .environmentObject(userStore)
        }
    }
}
