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
            userStore.image
                .resizable()
                .foregroundColor(.white)
                .frame(width: 48, height: 48)
                .background(.green)
                .clipShape(Circle())
                .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(userStore.username)
                    .font(.subheadline)
                
                Text("@\(userStore.username)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}
