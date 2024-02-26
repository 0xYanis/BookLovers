//
//  LoginView.swift
//  BookLovers
//
//  Created by Yanis on 07.02.2024.
//

import SwiftUI
import Components

struct LoginView: View {
    private let isRegistrationView: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var secondPassword = ""
    @Environment(\.dismiss) private var dismiss
    
    init(isRegistrationView: Bool = false) {
        self.isRegistrationView = isRegistrationView
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                booklyGradient
                    .opacity(0.2)
                    .ignoresSafeArea()
                
                
                VStack(alignment: .center, spacing: 25) {
                    HStack(alignment: .center, spacing: 0) {
                        Image("logo-small")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .opacity(0.95)
                        Text("Bookly")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .fontDesign(.rounded)
                            .foregroundStyle(.linearGradient(
                                colors: [.purple, .green],
                                startPoint: .bottomLeading,
                                endPoint: .topTrailing))
                    }
                    .padding(.bottom, 64)
                    emailField
                    secureField
                    if isRegistrationView { secondField }
                    Divider()
                    if !isRegistrationView { signUpLabel }
                    signInButton
                    HStack {
                        //appleIdButton
                        Spacer()
                    }
                }
                .padding()
                .padding(.horizontal)
            }
        }
    }
    
    private var logoImage: some View {
        Image("reading")
            .resizable()
            .scaledToFit()
            .frame(width: 150)
    }
    
    private var emailField: some View {
        TextField("Entry your email", text: $email)
            .padding(.horizontal)
            .padding(.vertical, 12)
            .background(Color(.secondarySystemFill))
            .clipShape(Capsule())
    }
    
    private var secureField: some View {
        InteractedSecureField("Entry your password", text: $password)
            .background(Color(.secondarySystemFill))
            .clipShape(Capsule())
    }
    
    private var secondField: some View {
        InteractedSecureField("Confirm your password", text: $secondPassword)
            .background(Color(.secondarySystemFill))
            .clipShape(Capsule())
    }
    
    private var signUpLabel: some View {
        HStack {
            Text("Already have an account?")
            
            NavigationLink {
                RegistrationView()
            } label: {
                Text("Sign up")
                    .underline()
            }
        }
        .font(.subheadline)
    }
    
    private var signInButton: some View {
        Button("Sign \(isRegistrationView ? "up" : "in")") {
            
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.green)
        .clipShape(Capsule())
    }
    
    private var appleIdButton: some View {
        Button {
            
        } label: {
            Image(systemName: "apple.logo")
            Text("Apple ID")
        }
        .foregroundStyle(.white)
        .padding(12)
        .background(Color.black)
        .clipShape(Capsule())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

extension View {
    var booklyGradient: LinearGradient {
        LinearGradient(
            colors: [.purple, .green],
            startPoint: .bottomLeading,
            endPoint: .topTrailing
        )
    }
}
