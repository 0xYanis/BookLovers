//
//  AuthViewModel.swift
//  BookLovers
//
//  Created by Yanis on 26.02.2024.
//

import Foundation
import Combine
import FirebaseAuth

final class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var secondPassword = ""
    @Published var showVerification = false
    @Published var loginType: LoginType = .login
    
    @Published private(set) var errorMessage = ""
    @Published private(set) var canLogin = false
    @Published private(set) var successLogin = false
    
    @Published private var emailIsValid = false
    @Published private var passwordIsValid = false
    @Published private var confirmationIsValid = false
    
    private let auth = Auth.auth()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        observation()
        authObservation()
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    func signIn() {
        guard canLogin else { return }
        Task {
            do {
                if loginType == .login {
                    try await verifyLogin()
                } else {
                    try await verifySignUp()
                }
            } catch {
                await presentError(error)
            }
        }
    }
    
    func checkLogin() {
        if let user = auth.currentUser {
            user.reload()
            if user.isEmailVerified {
                successLogin = true
                showVerification = false
            }
        }
    }
    
    func cancelLogin() {
        showVerification = false
        if let user = auth.currentUser {
            user.delete()
        }
    }
    
    // MARK: - Private methods
    
    @MainActor
    private func presentError(_ error: Error) async {
        guard errorMessage.isEmpty else { return }
        errorMessage = error.localizedDescription
    }
    
    private func verifyLogin() async throws {
        let result = try await auth.signIn(withEmail: email, password: password)
        if result.user.isEmailVerified {
            successLogin = true
        } else {
            try await result.user.sendEmailVerification()
            showVerification.toggle()
        }
    }
    
    private func verifySignUp() async throws {
        let result = try await auth.createUser(withEmail: email, password: password)
        try await result.user.sendEmailVerification()
        await MainActor.run { successLogin = true; showVerification.toggle() }
    }
}

// MARK: - Private combine pipelines (validation logic)

private extension AuthViewModel {
    enum ValidMessage: String {
        case email = "Mail must contain @ and '.' (dot) and not contain spaces"
        case password = "The password must have at least 6 characters and not contain spaces"
        case confirmation = "Passwords must match"
    }
    
    func observation() {
        $email
            .debounce(for: 1.5, scheduler: RunLoop.main)
            .map { $0.contains("@") && $0.contains(".") && $0.notContains(" ") }
            .sink { [weak self] isValid in
                guard self?.email.isEmpty == false else { self?.errorMessage.removeAll(); return }
                if !isValid { self?.errorMessage = ValidMessage.email.rawValue }
                else { self?.errorMessage.removeAll() }
                self?.emailIsValid = isValid
            }
            .store(in: &cancellables)
        
        $password
            .debounce(for: 1.5, scheduler: RunLoop.main)
            .map { $0.notContains(" ") && $0.count >= 6 }
            .sink { [weak self] isValid in
                guard self?.password.isEmpty == false else { self?.errorMessage.removeAll(); return }
                if !isValid { self?.errorMessage = ValidMessage.password.rawValue }
                else { self?.errorMessage.removeAll() }
                self?.passwordIsValid = isValid
            }
            .store(in: &cancellables)
        
        $secondPassword
            .debounce(for: 1.5, scheduler: RunLoop.main)
            .map { [weak self] in $0 == self?.password }
            .sink { [weak self] isValid in
                guard self?.secondPassword.isEmpty == false else { self?.errorMessage.removeAll(); return }
                if !isValid { self?.errorMessage = ValidMessage.confirmation.rawValue }
                else { self?.errorMessage.removeAll() }
                self?.confirmationIsValid = isValid
            }
            .store(in: &cancellables)
    }
    
    func authObservation() {
        $loginType
            .combineLatest($emailIsValid, $passwordIsValid, $confirmationIsValid)
            .map { type, email, password, confirmation in
                if type == .login {
                    return email && password
                } else {
                    return email && password && confirmation
                }
            }
            .assign(to: &$canLogin)
    }
}

extension String {
    func notContains<T>(_ other: T) -> Bool where T : StringProtocol {
        !self.contains(other)
    }
}
