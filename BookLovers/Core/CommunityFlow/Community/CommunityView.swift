//
//  CommunityView.swift
//  BookLovers
//
//  Created by Yanis on 07.02.2024.
//

import SwiftUI

struct CommunityView: View {
    @EnvironmentObject private var userStore: UserStore
    
    var body: some View {
        NavigationStack {
            currentView
        }
    }
    
    private var currentView: some View {
        CreateCommunityView()
        //communityList
    }
    
    private var communityList: some View {
        ScrollView {
            
        }
        .listStyle(.plain)
        .toolbar {
            titleLabel
            addButton
            userButton
        }
    }
    
    private var titleLabel: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Text("Communities")
                .font(.title)
                .fontWeight(.bold)
        }
    }
    
    private var addButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.title3)
                    .foregroundStyle(Color.gray)
                    .clipShape(Circle())
            }
        }
    }
    
    private var userButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            NavigationLink(destination: ProfileView()) {
                Avatar(url: userStore.user.avatar)
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                    .background(Color.gray)
                    .clipShape(Circle())
            }
        }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView().environmentObject(UserStore())
    }
}
