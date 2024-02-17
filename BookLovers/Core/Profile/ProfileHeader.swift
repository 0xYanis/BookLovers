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
            Text("0xYanis")
                .font(.title2)
                .fontWeight(.semibold)
                .matchedGeometryEffect(id: "nickname", in: headerSnap)
                .padding(.bottom, 10)
        }
    }
    
    private var normalStateView: some View {
        ZStack(alignment: .bottom) {
            Rectangle().fill(.gray.opacity(0.15))
            VStack {
                Image("avatar")
                    .resizable()
                    .scaledToFit()
                    .matchedGeometryEffect(id: "avatar", in: headerSnap)
                    .frame(width: 130)
                    .clipShape(Circle())
                
                
                Text("0xYanis")
                    .font(.title)
                    .fontWeight(.semibold)
                    .matchedGeometryEffect(id: "nickname", in: headerSnap)
                    .padding(.bottom, 30)
            }
        }
    }
    
    private var extendedStateView: some View {
        ZStack {
            Image("avatar")
                .resizable()
                .matchedGeometryEffect(id: "avatar", in: headerSnap)
                .scaledToFill()
                .frame(width: screen.width)
                .overlay(alignment: .bottomLeading) {
                    Text("0xYanis")
                        .underline()
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .matchedGeometryEffect(id: "nickname", in: headerSnap)
                        .padding(.bottom, 60)
                        .padding(.leading)
                }
        }
    }
}

struct ProfileHeader_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
