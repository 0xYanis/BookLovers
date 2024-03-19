//
//  LoginView.swift
//  BookLovers
//
//  Created by Yanis on 07.02.2024.
//

import SwiftUI
import Components

struct LoginView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = AuthViewModel(auth: AuthWorker())
    @EnvironmentObject private var userStore: UserStore
    @State private var isSecure = true
    @State private var showResetView = false
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 15) {
                    titleLabel
                    
                    VStack(alignment: .trailing, spacing: 15) {
                        LoginPicker(loginType: $viewModel.loginType)
                        
                        Section(content: textFields, header: errorMessage)
                        
                        Button("Forgot password?", action: forgotTapped)
                            .font(.callout)
                        Button(action: signInAction) {
                            Text(viewModel.loginType == .login ? "Sign In!" : "Sign Up!")
                                .foregroundStyle(.white)
                                .padding(12)
                                .background(.green)
                                .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)
                        .disabled(!viewModel.canLogin)
                    }
                    .animation(.spring(), value: viewModel.errorMessage)
                    .animation(.spring(), value: viewModel.loginType)
                    .padding()
                }
            }
            .scrollContentBackground(.hidden)
            .background(booklyGradient.opacity(0.3))
            .toolbar(content: xbarButton)
            .sheet(isPresented: $viewModel.showVerification) {
                EmailVerificationView(viewModel: viewModel)
                    .presentationDragIndicator(.hidden)
                    .presentationDetents([.height(350)])
                    .interactiveDismissDisabled()
            }
            .sheet(isPresented: $showResetView) {
                ResetPasswordView(viewModel: viewModel)
                    .presentationDragIndicator(.hidden)
                    .presentationDetents([.height(250)])
            }
        }
        .onChange(of: viewModel.successLogin) { newValue in
            if newValue == true { dismiss.callAsFunction() }
            userStore.setStatus(isAuthenticated: newValue)
        }
    }
    
    private var titleLabel: some View {
        Text("👋 Welcome Back!")
            .font(.largeTitle)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }
    
    private func xbarButton() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            XButton(action: dismiss.callAsFunction)
        }
    }
    
    @ViewBuilder
    private func textFields() -> some View {
        AuthTextField(.email, text: $viewModel.email)
        AuthTextField(.password, text: $viewModel.password, isSecure: isSecure)
            .overlay(alignment: .trailing) {
                Button {
                    isSecure.toggle()
                } label: {
                    Image(systemName: isSecure ? "eye.slash" : "eye")
                }
                .buttonStyle(.plain)
                .padding(.trailing, 12)
            }
        
        if viewModel.loginType == .signup {
            AuthTextField(.confirmation, text: $viewModel.secondPassword, isSecure: isSecure)
                .transition(.move(edge: .leading).combined(with: .opacity))
        }
    }
    
    private func errorMessage() -> some View {
        Text(viewModel.errorMessage)
            .font(.caption)
            .foregroundStyle(.red)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func signInAction() {
        viewModel.signButtonTapped()
    }
    
    private func forgotTapped() {
        showResetView = true
    }
}

fileprivate struct LoginPicker: View {
    @Binding var loginType: LoginType
    
    var body: some View {
        Picker("Login type", selection: $loginType) {
            ForEach(LoginType.allCases) { type in
                Text(type.rawValue.capitalized).tag(type)
            }
        }
        .pickerStyle(.segmented)
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(UserStore())
    }
}
