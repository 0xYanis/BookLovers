//
//  ProfileHeader.swift
//  BookLovers
//
//  Created by Yanis on 17.02.2024.
//

import SwiftUI

struct ProfileAvatar: View {
    private let size: CGFloat
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var userStore: UserStore
    
    init(size: CGFloat = 130) {
        self.size = size
    }
    
    var body: some View {
        Avatar(url: userStore.user.avatar)
            .scaledToFill()
            .frame(width: size, height: size)
            .background(colorScheme == .light ? Color.white : Color.gray)
            .clipShape(Circle())
    }
}

struct ProfileHeader_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserStore())
    }
}
