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
                titleLabel
                subtitleLabel
                HStack {
                    AuthTextField(.email, text: $viewModel.resetEmail)
                    if showButton { sendLinkButton }
                }
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .animation(.spring(), value: showButton)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(booklyGradient.opacity(0.3))
        .overlay(alignment: .topTrailing, content: cancelButton)
        .onChange(of: viewModel.resetEmail) {
            showButton =
            $0.contains("@") &&
            $0.contains(".") &&
            $0.notContains(" ")
        }
    }
    
    private var titleLabel: some View {
        Text("Reset password")
            .font(.title.bold())
            .padding(.top)
    }
    
    private var subtitleLabel: some View {
        Text("Enter the email address")
            .font(.callout)
            .foregroundStyle(.gray)
    }
    
    private var sendLinkButton: some View {
        Button("Send link", action: sendLinkTapped)
            .padding(12)
            .background(Color(.systemBackground))
            .clipShape(Capsule())
            .transition(.move(edge: .trailing).combined(with: .opacity))
    }
    
    private func cancelButton() -> some View {
        Button("Cancel", action: cancel).padding()
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
