//
//  ResetPasswordView.swift
//  BookLovers
//
//  Created by Yanis on 07.03.2024.
//

import SwiftUI

struct ResetPasswordView: View {
    @ObservedObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showButton = false
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 22) {
                Text("Reset password")
                    .font(.title.bold())
                    .padding(.top)
                
                Text("Enter the email address")
                    .font(.callout)
                    .foregroundStyle(.gray)
                
                HStack {
                    AuthTextField(.email, text: $viewModel.resetEmail)
                    if showButton {
                        Button("Send link", action: sendLinkTapped)
                            .padding(12)
                            .background(Color(.systemBackground))
                            .clipShape(Capsule())
                            .transition(.move(edge: .trailing).combined(with: .opacity))
                    }
                }
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .animation(.spring(), value: showButton)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Material.ultraThinMaterial)
        .overlay(alignment: .topTrailing) {
            Button("Cancel", action: cancel).padding()
        }
        .onChange(of: viewModel.resetEmail) {
            showButton =
            $0.contains("@") &&
            $0.contains(".") &&
            $0.notContains(" ")
        }
    }
    
    private func sendLinkTapped() {
        viewModel.sendResetLink()
        dismiss.callAsFunction()
    }
    
    private func cancel() {
        viewModel.resetEmail.removeAll()
        dismiss.callAsFunction()
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView(viewModel: AuthViewModel())
    }
}
