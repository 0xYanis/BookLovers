//
//  CommunityView.swift
//  BookLovers
//
//  Created by Yanis on 07.02.2024.
//

import SwiftUI
import Components

struct CommunityView: View {
    @State private var showLogin = false
    @EnvironmentObject private var userStore: UserStore
    
    var body: some View {
        NavigationStack {
            currentView
        }
    }
    
    private var currentView: some View {
        createCommunityView
            .overlay(alignment: .bottom) {
                BigButton(title: "Create community", action: { showLogin.toggle() })
                    .padding(.bottom, 64)
                    .padding(.horizontal)
            }
            .sheet(isPresented: $showLogin) {
                LoginView()
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.hidden)
            }
    }
    
    private var createCommunityView: some View {
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
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView().environmentObject(UserStore())
    }
}
