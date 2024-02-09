//
//  OnboardingView.swift
//  BookLovers
//
//  Created by Yanis on 09.02.2024.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isShowing: Bool
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            firstView
                .navigationDestination(for: WelcomeMessage.self) { screen in
                    switch screen {
                    case .first : firstView
                    case .second: secondView
                    case .third : thirdView
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        XButton(action: dismiss)
                    }
                }
        }
    }
    
    private var firstView: some View {
        WelcomeView(
            title: WelcomeMessage.first.rawValue,
            items: WelcomeFeature.firstScreen,
            subbuttonTitle: "",
            bigButtonTitle: "Continue",
            subbuttonAction: {}
        ) {
            tapAction(of: .first)
        }
    }
    
    private var secondView: some View {
        WelcomeView(
            title: WelcomeMessage.second.rawValue,
            items: WelcomeFeature.secondScreen,
            subbuttonTitle: "",
            bigButtonTitle: "Continue",
            subbuttonAction: {}
        ) {
            tapAction(of: .second)
        }
    }
    
    private var thirdView: some View {
        WelcomeView(
            title: WelcomeMessage.second.rawValue,
            items: WelcomeFeature.secondScreen,
            subbuttonTitle: "",
            bigButtonTitle: "Ready!",
            subbuttonAction: {}
        ) {
            tapAction(of: .third)
        }
    }
    
    private func tapAction(of screen: WelcomeMessage) {
        path.append(screen)
    }
    
    private func dismiss() {
        isShowing.toggle()
    }
}
