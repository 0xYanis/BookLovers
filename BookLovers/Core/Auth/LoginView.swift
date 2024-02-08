//
//  LoginView.swift
//  BookLovers
//
//  Created by Yanis on 07.02.2024.
//

import SwiftUI

struct LoginView: View {
    let isRegistrationView: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var secondPassword = ""
    @Environment(\.dismiss) private var dismiss
    
    init(isRegistrationView: Bool = false) {
        self.isRegistrationView = isRegistrationView
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 25) {
                    Text("BookLovers")
                        .font(.title3)
                        .fontWeight(.black)
                        .fontDesign(.rounded)
                    
                    logoImage
                    
                    emailField
                    
                    secureField
                    
                    if isRegistrationView {
                        secondField
                    }
                    
                    if !isRegistrationView {
                        signUpLabel
                    }
                    
                    signInButton
                    
                    Divider()
                    
                    HStack {
                        //appleIdButton
                        
                        Spacer()
                    }
                }
                .padding()
                .padding(.horizontal)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    XButton(action: dismiss.callAsFunction)
                }
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
