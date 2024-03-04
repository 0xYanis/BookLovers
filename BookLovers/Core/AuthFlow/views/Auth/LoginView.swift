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
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var viewModel: AuthViewModel
    
    @State private var isSecure = true
    @State private var loginType: LoginType = .login
    
    init(isRegistrationView: Bool = false, viewModel: AuthViewModel) {
        self.isRegistrationView = isRegistrationView
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                booklyGradient.opacity(0.2).ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .trailing, spacing: 15) {
                        LoginPicker(loginType: $loginType).padding(.bottom)
                        Section {
                            AuthTextField(
                                image: "person.fill",
                                placeholder: "Entry email",
                                text: $viewModel.email)
                            AuthTextField(
                                image: "lock.open.fill",
                                placeholder: "Entry password",
                                text: $viewModel.password,
                                isSecure: isSecure)
                            .overlay(alignment: .trailing) {
                                Button {
                                    isSecure.toggle()
                                } label: {
                                    Image(systemName: isSecure ? "eye.slash" : "eye")
                                }
                                .buttonStyle(.plain)
                                .padding(.trailing, 12)
                            }
                            
                            if loginType == .signup {
                                AuthTextField(
                                    image: "lock.open.fill",
                                    placeholder: "Confirm password",
                                    text: $viewModel.secondPassword,
                                    isSecure: isSecure)
                                .transition(.move(edge: .leading).combined(with: .opacity))
                            }
                        } header: {
                            Text("")
                                .font(.caption)
                                .foregroundStyle(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }

                        
                        Button {
                            
                        } label: {
                            Text(loginType == .login ? "Sign In!" : "Sign Up!")
                                .foregroundStyle(.white)
                                .padding(12)
                                .background(.primary)
                                .clipShape(Capsule())
                        }
                        .padding(.top)
                    }
                    .animation(.spring(), value: loginType)
                    .padding()
                }
                .listStyle(.plain)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        XButton(action: dismiss.callAsFunction)
                    }
                }
            }
            .navigationTitle("Welcome Back!")
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
        LoginView(viewModel: AuthViewModel(isLogin: true))
            .environmentObject(UserStore())
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
