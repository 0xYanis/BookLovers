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
        NavigationStack {
            ScrollView {
                createCommunityView
            }
            .navigationTitle("Communities")
            .sheet(isPresented: $showLogin, content: LoginView.init)
        }
    }
    
    private var createCommunityView: some View {
        VStack(spacing: 60) {
            Spacer()
            
            Text("👨‍👩‍👧‍👦")
                .font(.largeTitle)
                .padding()
                .background(Color.green.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(spacing: 15) {
                Text("Create your community")
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .font(.title2)
                
                Text("Invite friends and chat with like-minded people")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            Button {
                if userStore.user.isAuthenticated {
                    
                } else {
                    showLogin.toggle()
                }
            } label: {
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
}

struct CommunityListView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityListView()
    }
}
