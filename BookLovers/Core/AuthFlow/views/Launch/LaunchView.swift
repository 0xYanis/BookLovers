//
//  LaunchView.swift
//  BookLovers
//
//  Created by Yanis on 14.02.2024.
//

import SwiftUI
import Components
import WelcomeSheet

struct LaunchView: View {
    private let animated: Bool
    @State private var isLaunched = true
    @State private var imageWidth: CGFloat = 300
    @State private var isTop = false
    @State private var isFinished = false
    @StateObject private var viewModel = LaunchViewModel()
    @Environment(\.colorScheme) private var scheme
    
    init(animated: Bool) {
        self.animated = animated
    }
    
    var body: some View {
        ZStack {
            if animated {
                if isLaunched {
                    backgroundView
                    launchLogo.opacity(isFinished ? 0.0 : 1.0)
                }
                MainTabbarView()
                    .opacity(isFinished ? 1.0 : 0.0)
                    .welcomeSheet(
                        isPresented: $viewModel.showWelcomeSheet,
                        preferredColorScheme: scheme,
                        pages: viewModel.pages)
            } else {
                MainTabbarView()
            }
        }
        .onAppear {
            if animated {
                Task { @MainActor in
                    await animationPart(response: 2) { imageWidth = 330 } // increase
                    await animationPart(sleep: 2, response: 1) { imageWidth = 30 } // fast decrease
                    await animationPart(sleep: 0.3, response: 1) { isTop = true } // going top
                    await animationPart(sleep: 1.5, response: 1) { isFinished = true } // stopping
                    await animationPart(sleep: 1, response: 1) {
                        isLaunched = false
                        viewModel.checkOnboarding()
                    } // showing main view
                }
            }
        }
    }
    
    private var launchLogo: some View {
        VStack {
            HStack {
                Image("logo-big")
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageWidth)
            }
            .padding(.horizontal)
            
            if isTop { Spacer() }
        }
    }
    
    private var backgroundView: some View {
        LinearGradient(
            colors: [.purple.opacity(0.8), .red.opacity(0.8)],
            startPoint: isTop ? .top : .topLeading,
            endPoint: .bottomTrailing)
        .background(Material.ultraThin)
        .ignoresSafeArea()
    }
    
    private func animationPart(
        sleep: Double = 0.0,
        response: Double,
        action: () -> ()
    ) async {
        if sleep != 0.0 {
            try? await Task.sleep(for: .seconds(sleep))
        }
        withAnimation(.spring(response: response)) {
            action()
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(animated: false)
            .environmentObject(UserStore())
    }
}
