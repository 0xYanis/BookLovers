//
//  CreateCommunityView.swift
//  BookLovers
//
//  Created by Yanis on 27.03.2024.
//

import SwiftUI
import Components

struct CreateCommunityView: View {
    @State private var showLogin = false
    @EnvironmentObject private var userStore: UserStore
    
    var body: some View {
        VStack(spacing: 32) {
            Text("👨‍👩‍👧‍👦")
                .font(.largeTitle)
                .padding(20)
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
            VStack(spacing: 12) {
                Text("Create your community")
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                Text("Invite friends and chat with like-minded people")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 32)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            BigButton(title: "Create community", action: createTapped)
                .padding(.bottom, 64)
                .padding(.horizontal)
        }
        .sheet(isPresented: $showLogin) {
            LoginView()
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.hidden)
        }
    }
    
    private func createTapped() {
        if userStore.user.isAuthenticated {
            
        } else {
            showLogin.toggle()
        }
    }
}
