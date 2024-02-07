//
//  SignInView.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

struct SignInView: View {
    let title: String
    let subtitle: String
    let description: String
    let buttonText: String
    @Binding var requestSignIn: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.green.opacity(0.3).ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Image("reading")
                    .resizable()
                    .scaledToFit()
                    .padding(50)
                
                VStack(alignment: .center, spacing: 32) {
                    Text(title)
                        .font(.title)
                        .fontDesign(.rounded)
                        .fontWeight(.semibold)
                    
                    Text(subtitle)
                        .font(.headline)
                        .fontDesign(.rounded)
                    
                    Text(description)
                        .multilineTextAlignment(.center)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 30)
                    
                    Button(buttonText) {
                        requestSignIn.toggle()
                    }
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.green)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                    Spacer()
                }
                .padding(.top, 32)
                .frame(maxWidth: .infinity)
                .background(Color(.systemBackground))
                .clipShape(CustomCornersShape(
                    corners: [.topLeft, .topRight],
                    radius: 64))
                .shadow(radius: 15)
            }
            .ignoresSafeArea()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(
            title: "Your favorites",
            subtitle: "Anytime",
            description: "To see, append and edit favorite books you need to sign in.",
            buttonText: "Get started",
            requestSignIn: .constant(false))
    }
}
