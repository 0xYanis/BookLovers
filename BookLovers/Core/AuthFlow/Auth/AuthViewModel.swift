//
//  AuthViewModel.swift
//  BookLovers
//
//  Created by Yanis on 26.02.2024.
//

import Foundation
import Combine

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var resetEmail = ""
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
    
    private var auth: AuthWorkerProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    init(auth: AuthWorkerProtocol) {
        self.auth = auth
        observation()
        authObservation()
    }
    
    deinit { cancellables.removeAll() }
    
    func signButtonTapped() {
        switch loginType {
        case .login:
            verifyLogin()
        case .signup:
            showVerification = true
            verifySignUp()
        }
    }
    
    func checkLogin() {
        if auth.isEmailVerified {
            showVerification = false
            successLogin = true
        }
    }
    
    func cancelLogin() {
        auth.deleteUser()
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                if case let .failure(error) = completion { self?.presentError(error) }
            } receiveValue: { [weak self] _ in self?.showVerification = false }
            .store(in: &cancellables)
    }
    
    func sendResetLink() {
        auth.sendResetLink(resetEmail)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                if case let .failure(error) = completion { self?.presentError(error) }
            } receiveValue: {_ in}
            .store(in: &cancellables)
    }
    
    // MARK: - Private methods
    
    private func presentError(_ error: Error) {
        guard errorMessage.isEmpty else { return }
        errorMessage = error.localizedDescription
    }
    
    private func verifyLogin() {
        auth.signin(email, password)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                if case let .failure(error) = completion { self?.presentError(error) }
            } receiveValue: { [weak self] user in
                if user.isEmailVerified {
                    self?.successLogin = true
                }
            }
            .store(in: &cancellables)
    }
    
    private func verifySignUp() {
        auth.signUp(email, password)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                if case let .failure(error) = completion { self?.presentError(error) }
            } receiveValue: { user in
                user.sendEmailVerification()
            }
            .store(in: &cancellables)
    }
}

// MARK: - Private validation logic

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
    
    func emailToName() -> String {
        if let atIndex = self.firstIndex(of: "@") {
            return String(self[..<atIndex])
        }
        return self
    }
}
