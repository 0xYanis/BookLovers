//
//  CommunityView.swift
//  BookLovers
//
//  Created by Yanis on 07.02.2024.
//

import SwiftUI

struct CommunityView: View {
    @EnvironmentObject private var userStore: UserStore
    @State private var requestSignIn = false
    
    var body: some View {
        NavigationStack {
            if userStore.user.isAuthenticated {
                CreateCommunityView()
            } else {
                SignInView(type: .community, requestSignIn: $requestSignIn)
            }
        }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView().environmentObject(UserStore())
    }
}
