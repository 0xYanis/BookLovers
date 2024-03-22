//
//  ProfileHeader.swift
//  BookLovers
//
//  Created by Yanis on 17.02.2024.
//

import SwiftUI

struct ProfileAvatar: View {
    @EnvironmentObject private var userStore: UserStore
    
    var body: some View {
        Avatar(url: userStore.user.avatar)
            .scaledToFill()
            .frame(width: 130, height: 130)
            .clipShape(Circle())
            .clipped()
    }
}

struct ProfileHeader_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserStore())
    }
}
