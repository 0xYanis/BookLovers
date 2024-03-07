//
//  ProfileHeader.swift
//  BookLovers
//
//  Created by Yanis on 17.02.2024.
//

import SwiftUI

struct ProfileHeader: View {
    @Binding var currentSnapPos: SnapPosition
    var headerSnap: Namespace.ID
    
    @EnvironmentObject private var userStore: UserStore
    
    var body: some View {
        switch currentSnapPos {
        case .hide    : hideStateView
        case .normal  : normalStateView
        case .extended: extendedStateView
        }
    }
    
    private var hideStateView: some View {
        ZStack(alignment: .bottom) {
            Rectangle().fill(.gray.opacity(0.15))
        }
    }
    
    private var normalStateView: some View {
        ZStack(alignment: .bottom) {
            Rectangle().fill(.gray.opacity(0.15))
            VStack {
                Avatar(url: userStore.user.avatar)
                    .scaledToFill()
                    .matchedGeometryEffect(id: "avatar", in: headerSnap)
                    .frame(width: 130, height: 130)
                    .clipShape(Circle())
                    .clipped()
                
                
                Text(userStore.user.username)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom, 30)
            }
        }
    }
    
    private var extendedStateView: some View {
        ZStack {
            Avatar(url: userStore.user.avatar)
                .matchedGeometryEffect(id: "avatar", in: headerSnap)
                .scaledToFill()
                .frame(width: screen.width, height: screen.height/2.5)
                .clipped()
                .overlay(alignment: .bottomLeading) {
                    Text(userStore.user.username)
                        .underline()
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(.bottom, 60)
                        .padding(.leading)
                }
        }
    }
}

struct ProfileHeader_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserStore())
    }
}
