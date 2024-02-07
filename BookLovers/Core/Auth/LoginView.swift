//
//  LoginView.swift
//  BookLovers
//
//  Created by Yanis on 07.02.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @Environment(\.dismiss) private var dismiss
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
                    
                    signUpLabel
                    
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
                ToolbarItem(placement: .navigationBarLeading) {
                    XButton(action: dismiss.callAsFunction)
                }
            }
        }
    }
    
    private var logoImage: some View {
        Image("reading")
            .resizable()
            .scaledToFit()
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
    
    private var signUpLabel: some View {
        HStack {
            Text("Don't have an account?")
            
            Button {
                
            } label: {
                Text("Sign up")
                    .underline()
            }
        }
        .font(.subheadline)
    }
    
    private var signInButton: some View {
        Button("Sign in") {
            
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
