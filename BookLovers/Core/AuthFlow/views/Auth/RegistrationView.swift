//
//  RegistrationView.swift
//  BookLovers
//
//  Created by Yanis on 08.02.2024.
//

import SwiftUI

struct RegistrationView: View {
    var body: some View {
        VStack {
            LoginView(isRegistrationView: true, viewModel: AuthViewModel(isLogin: false))
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
