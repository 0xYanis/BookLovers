//
//  AuthViewModel.swift
//  BookLovers
//
//  Created by Yanis on 26.02.2024.
//

import Foundation
import Combine

final class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var secondPassword = ""
    
    @Published private(set) var canLogin = false
    @Published private(set) var isValidEmail = false
    @Published private(set) var isValidPassword = false
    @Published private(set) var isValidSecondPassword = false
    
    private var cancellables: Set<AnyCancellable> = []
    private var isLogin: Bool
    
    init(isLogin: Bool) {
        self.isLogin = isLogin
        emailObserve()
        passwordObserve()
        confirmationObserve()
        checkAll()
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    func signIn() {
        
    }
    
    // MARK: - Private methods
    
    private func checkAll() {
        $isValidEmail
            .combineLatest($isValidPassword, $isValidSecondPassword)
            .map {
                return self.isLogin ? ($0 && $1) : ($0 && $1 && $2)
            }
            .sink { [weak self] value in
                self?.canLogin = value
            }
            .store(in: &cancellables)
    }
    
    private func emailObserve() {
        $email
            .map { $0.contains("@") && $0.contains(".") && $0.notContains(" ") }
            .sink { [weak self] isValid in
                self?.isValidEmail = isValid
            }
            .store(in: &cancellables)
    }
    
    private func passwordObserve() {
        $password
            .map { $0.count > 6 && $0.notContains(" ") }
            .sink { [weak self] isValid in
                self?.isValidPassword = isValid
            }
            .store(in: &cancellables)
    }
    
    private func confirmationObserve() {
        $password
            .combineLatest($secondPassword)
            .map { $0 == $1 }
            .sink { [weak self] isValid in
                self?.isValidSecondPassword = isValid
            }
            .store(in: &cancellables)
    }
}

extension String {
    func notContains<T>(_ other: T) -> Bool where T : StringProtocol {
        !self.contains(other)
    }
}
