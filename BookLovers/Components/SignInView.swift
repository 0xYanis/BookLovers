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
    @Binding var requestSignIn: Bool
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 64) {
                Spacer()
                VStack(alignment: .leading, spacing: 32) {
                    Text(title)
                        .fontDesign(.rounded)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(subtitle)
                        .font(.headline)
                }
                Button {
                    requestSignIn.toggle()
                } label: {
                    Text("Sign in")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.top, 32)
                .padding()
            }
            .padding()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(
            title: "Favorites",
            subtitle: "To see, append and edit favorite books \nyou need to sign in.",
            requestSignIn: .constant(false))
    }
}
