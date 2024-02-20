//
//  ProfileContent.swift
//  BookLovers
//
//  Created by Yanis on 17.02.2024.
//

import SwiftUI
import Components

struct ProfileContent: View {
    @State private var showSignIn = false
    @EnvironmentObject private var userStore: UserStore
    @Environment(\.colorScheme) private var scheme
    
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                HStack(spacing: 12) {
                    Image(systemName: "photo")
                        .imageScale(.large)
                    PhotosPickerView("Change photo")
                }
                .foregroundStyle(.green)
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(isDark ? Color(.tertiarySystemBackground) : Color.gray.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(spacing: 0) {
                if userStore.isAuthenticated {
                    label(text: "Email", image: "mail", color: .blue, divider: true)
                    label(text: "Password", image: "lock", color: .purple)
                } else {
                    BigButton(title: "Sign in") { showSignIn.toggle() }
                }
            }
            .background(isDark ? Color(.tertiarySystemBackground) : Color.gray.opacity(0.15))
            .clipShape(userStore.isAuthenticated ?
                       RoundedRectangle(cornerRadius: 10) :
                        RoundedRectangle(cornerRadius: 25))
            
            VStack(spacing: 0) {
                label(text: "Status", image: "text.bubble", color: .pink, divider: true)
                label(text: "Favorite genre", image: "book", color: .green)
            }
            .background(isDark ? Color(.tertiarySystemBackground) : Color.gray.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding()
        .sheet(isPresented: $showSignIn) { LoginView() }
    }
    
    private var isDark: Bool {
        scheme == .dark
    }
    
    private func label(
        text: String,
        image: String,
        color: Color? = nil,
        divider: Bool = false
    ) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                if let color = color {
                    RectImage(systemImage: image, color: color, screen: screen)
                } else {
                    Image(systemName: image)
                        .padding(5)
                }
                Text(text)
            }
            .padding(8)
            .frame(maxWidth: .infinity, alignment: .leading)
            if divider {
                Divider()
                    .padding(.leading, 50)
            }
        }
    }
}

struct ProfileContent_Previews: PreviewProvider {
    static var previews: some View {
        ProfileContent()
            .environmentObject(UserStore())
    }
}
