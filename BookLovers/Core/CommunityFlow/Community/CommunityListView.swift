//
//  CommunityListView.swift
//  BookLovers
//
//  Created by Yanis on 09.02.2024.
//

import SwiftUI

struct CommunityListView: View {
    @EnvironmentObject private var userStore: UserStore
    @State private var showLogin = false
    
    var body: some View {
        ScrollView {
            createCommunityView
        }
        .navigationTitle("Communities")
        .sheet(isPresented: $showLogin) {
            LoginView()
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.hidden)
        }
    }
    
    private var createCommunityView: some View {
        VStack(spacing: 60) {
            Spacer()
            communityEmoji
            VStack(spacing: 15) {
                titleLabel
                subtitleLabel
            }
            Button(action: createCommunity) {
                Image(systemName: "plus")
                Text("New community")
            }
            .font(.headline)
            .buttonStyle(.plain)
            .foregroundStyle(.white)
            .padding(13)
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .padding()
        .padding(.horizontal)
    }
    
    private var communityEmoji: some View {
        Text("👨‍👩‍👧‍👦")
            .font(.largeTitle)
            .padding()
            .background(Color.green.opacity(0.7))
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    private var titleLabel: some View {
        Text("Create your community")
            .fontWeight(.semibold)
            .fontDesign(.rounded)
            .font(.title2)
    }
    
    private var subtitleLabel: some View {
        Text("Invite friends and chat with like-minded people")
            .font(.callout)
            .foregroundStyle(.gray)
            .multilineTextAlignment(.center)
    }
    
    private func createCommunity() {
        if userStore.user.isAuthenticated {
            // create community
        } else {
            showLogin.toggle()
        }
    }
}

struct CommunityListView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityListView()
    }
}
