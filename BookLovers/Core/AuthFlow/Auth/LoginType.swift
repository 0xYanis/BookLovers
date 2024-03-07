//
//  LoginType.swift
//  BookLovers
//
//  Created by Yanis on 07.03.2024.
//

import Foundation

enum LoginType: String, CaseIterable, Identifiable {
    case login
    case signup = "Sign up"
    
    var id: Self { self }
}
