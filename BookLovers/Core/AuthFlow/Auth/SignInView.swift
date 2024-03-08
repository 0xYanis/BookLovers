//
//  SignInView.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI
import Components

struct SignInView: View {
    private let title: String
    private let subtitle: String
    private let description: String
    private let buttonText: String
    @Binding var requestSignIn: Bool
    
    init(
        title: String,
        subtitle: String,
        description: String,
        buttonText: String,
        requestSignIn: Binding<Bool>
    ) {
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.buttonText = buttonText
        self._requestSignIn = requestSignIn
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.green.opacity(0.3).ignoresSafeArea()
            VStack {
                Spacer()
                headerView
                contentView
            }
            .ignoresSafeArea()
        }
        .sheet(isPresented: $requestSignIn) {
            LoginView()
                .presentationDetents([.medium, .large])
        }
    }
    
    private var headerView: some View {
        Image("reading")
            .resizable()
            .scaledToFit()
            .padding(50)
    }
    
    private var contentView: some View {
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
            BigButton(title: title) {
                requestSignIn.toggle()
            }
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
}

extension SignInView {
    init(
        type: SignInType,
        requestSignIn: Binding<Bool>
    ) {
        self.title = type.title
        self.subtitle = type.subtitle
        self.description = type.description
        self.buttonText = "Get started"
        self._requestSignIn = requestSignIn
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(
            type: .favorites,
            requestSignIn: .constant(false))
    }
}
