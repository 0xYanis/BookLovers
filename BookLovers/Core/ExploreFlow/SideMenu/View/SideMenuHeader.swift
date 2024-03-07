//
//  SideMenuHeader.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

struct SideMenuHeader: View {
    @EnvironmentObject private var userStore: UserStore
    
    var body: some View {
        HStack {
            Avatar(url: userStore.user.avatar)
                .foregroundColor(.white)
                .frame(width: 48, height: 48)
                .background(.green)
                .clipShape(Circle())
                .background(Circle().stroke().fill(Color.gray))
                .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(userStore.user.username)
                    .font(.subheadline)
                
                Text("@\(userStore.user.username)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}
