//
//  LaunchView.swift
//  BookLovers
//
//  Created by Yanis on 14.02.2024.
//

import SwiftUI

struct LaunchView: View {
    @State private var isLaunched = true
    @State private var opacity: CGFloat = 1.0
    @State private var imageWidth: CGFloat = 300
    @State private var isTop = false
    @State private var isFinished = false
    
    var body: some View {
        ZStack {
            if isLaunched {
                backgroundView
                
                launchLogo
                .opacity(opacity)
            }
            
            MainTabbarView()
                .opacity(isFinished ? 1.0 : 0.0)
            
        }
        .onAppear {
            Task { @MainActor in
                // increase
                withAnimation(.spring(response: 2)) {
                    imageWidth = 330
                }
                
                // fast decrease
                try await Task.sleep(for: .seconds(2))
                withAnimation(.spring(response: 1)) {
                    imageWidth = 30
                }
                
                // going top
                try await Task.sleep(for: .seconds(0.3))
                withAnimation(.spring(response: 1)) {
                    isTop = true
                }
                
                // stopping
                try await Task.sleep(for: .seconds(1.5))
                withAnimation(.spring(response: 1)) {
                    opacity = 0.0
                    isFinished = true
                }
                
                // showing main view
                try await Task.sleep(for: .seconds(1))
                withAnimation(.spring(response: 1)) {
                    isLaunched = false
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
            
            if isTop {
                Spacer()
            }
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
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            .environmentObject(UserStore())
    }
}
