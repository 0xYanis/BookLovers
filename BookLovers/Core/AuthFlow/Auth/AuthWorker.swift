//
//  AuthWorker.swift
//  BookLovers
//
//  Created by Yanis on 08.03.2024.
//

import Foundation
import FirebaseAuth
import Combine

protocol AuthWorkerProtocol: AnyObject {
    var isEmailVerified: Bool { get }
    
    func deleteUser() -> AnyPublisher<Never, Error>
    func signin(_ email: String,_ password: String) -> AnyPublisher<FirebaseAuth.User, Error>
    func signUp(_ email: String,_ password: String) -> AnyPublisher<FirebaseAuth.User, Error>
    func sendResetLink(_ email: String) -> AnyPublisher<Never, Error>
}

class AuthWorker: AuthWorkerProtocol {
    private let auth = Auth.auth()
    
    var isEmailVerified: Bool {
        guard let user = auth.currentUser else { return false }
        user.reload()
        return user.isEmailVerified
    }
    
    func deleteUser() -> AnyPublisher<Never, Error> {
        return Future<Never, Error> { promise in
            self.auth.currentUser?.delete { error in
                if let error { promise(.failure(error)) }
            }
        }.eraseToAnyPublisher()
    }
    
    func signin(_ email: String,_ password: String) -> AnyPublisher<FirebaseAuth.User, Error> {
        return Future<FirebaseAuth.User, Error> { promise in
            self.auth.signIn(withEmail: email, password: password) { result, error in
                if let error { promise(.failure(error)) }
                if let result { promise(.success(result.user)) }
            }
        }.eraseToAnyPublisher()
    }
    
    func signUp(_ email: String,_ password: String) -> AnyPublisher<FirebaseAuth.User, Error> {
        return Future<FirebaseAuth.User, Error> { promise in
            self.auth.createUser(withEmail: email, password: password) { result, error in
                if let error { promise(.failure(error)) }
                if let result { promise(.success(result.user)) }
            }
        }.eraseToAnyPublisher()
    }
    
    func sendResetLink(_ email: String) -> AnyPublisher<Never, Error> {
        return Future<Never, Error> { promise in
            self.auth.sendPasswordReset(withEmail: email) { error in
                if let error { promise(.failure(error)) }
            }
        }.eraseToAnyPublisher()
    }
}
