//
//  AuthView.swift
//  BookLovers
//
//  Created by Yanis on 13.02.2024.
//

import SwiftUI
import Components

struct AuthView: View {
    @State private var showSignUp = false
    @State private var showSignIn = false
    
    var body: some View {
        ZStack {
            // optional background
            
            // main
            authView
            
            // sign up
            if showSignUp {
                RegistrationView()
            }
            
            // sign in
            if showSignIn {
                LoginView(viewModel: AuthViewModel(isLogin: true))
            }
        }
        .overlay(alignment: .topTrailing) {
            if showSignIn || showSignUp {
                XButton {
                    withAnimation(.spring()) {
                        showSignUp = false
                        showSignIn = false
                    }
                }
                .padding()
            }
        }
    }
    
    private var authView: some View {
        VStack(spacing: 48) {
            Image("logo-big")
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 300)
            
            VStack(spacing: 16) {
                Text("Welcome to the Bookly")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("More then 200,000 electronic and audiobooks are waiting for you.")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.gray)
                    .padding([.horizontal, .bottom], 32)
                
                bigButton(title: "Sign Up", action: signUpTapped)
                .padding(.bottom, 10)
                
                bigButton(title: "Sign In", isFilled: false, action: signInTapped)
                Spacer()
            }
        }
    }
    
    private func signUpTapped() {
        withAnimation(.spring()) {
            showSignUp.toggle()
        }
    }
    
    private func signInTapped() {
        withAnimation(.spring()) {
            showSignIn.toggle()
        }
    }
    
    private func bigButton(title: String, isFilled: Bool = true, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(isFilled ? .white : .green)
                .padding(12)
                .frame(maxWidth: .infinity)
                .background {
                    if isFilled {
                        Capsule()
                            .fill(Color.green)
                    } else {
                        Capsule()
                            .stroke(lineWidth: 3.0)
                            .fill(Color.green)
                    }
                }
        }
        .buttonStyle(.plain)
        .padding(.horizontal)
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
