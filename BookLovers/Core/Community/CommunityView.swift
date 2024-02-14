//
//  CommunityView.swift
//  BookLovers
//
//  Created by Yanis on 07.02.2024.
//

import SwiftUI

struct CommunityView: View {
    @State private var isLogin = true
    @State private var requestSignIn = false
    
    var body: some View {
        NavigationStack {
            if isLogin {
                CreateCommunityView()
            } else {
                SignInView(type: .community, requestSignIn: $requestSignIn)
            }
        }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
