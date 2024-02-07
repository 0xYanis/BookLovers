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
                title: "Your communities",
                subtitle: "Anytime",
                description: "To find your community, chat and share book preferences, you must sign in to your account.",
                buttonText: "Get started",
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
