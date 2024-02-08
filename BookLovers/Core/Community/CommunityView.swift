//
//  CommunityView.swift
//  BookLovers
//
//  Created by Yanis on 07.02.2024.
//

import SwiftUI

struct CommunityView: View {
    @State private var requestSignIn = false
    
    var body: some View {
        NavigationStack {
            SignInView(
                type: .community,
                requestSignIn: $requestSignIn)
            .popover(isPresented: $requestSignIn) {
                LoginView()
            }
        }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
