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
    @StateObject private var viewModel = AuthViewModel()
    @State private var isSecure = true
    @State private var showVerification = false
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 15) {
                    Text("👋 Welcome Back!")
                        .onTapGesture {
                            showVerification.toggle()
                        }
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    VStack(alignment: .trailing, spacing: 15) {
                        LoginPicker(loginType: $viewModel.loginType)
                        Section {
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
                        } header: {
                            Text(viewModel.errorMessage)
                                .font(.caption)
                                .foregroundStyle(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        Button(action: viewModel.signIn) {
                            Text(viewModel.loginType == .login ? "Sign In!" : "Sign Up!")
                                .foregroundStyle(.white)
                                .padding(12)
                                .background(.green)
                                .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)
                        .disabled(!viewModel.canLogin)
                        .padding(.top)
                    }
                    .animation(.spring(), value: viewModel.errorMessage)
                    .animation(.spring(), value: viewModel.loginType)
                    .padding()
                }
            }
            .scrollContentBackground(.hidden)
            .background(booklyGradient.opacity(0.3))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    XButton(action: dismiss.callAsFunction)
                }
            }
            .sheet(isPresented: $showVerification) {
                
            }
        }
    }
}

enum LoginType: String, CaseIterable, Identifiable {
    case login
    case signup = "Sign up"
    
    var id: Self { self }
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(UserStore())
    }
}

private extension View {
    var booklyGradient: LinearGradient {
        LinearGradient(
            colors: [.purple, .green],
            startPoint: .bottomLeading,
            endPoint: .topTrailing
        )
    }
}
