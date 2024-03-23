//
//  SignInType.swift
//  BookLovers
//
//  Created by Yanis on 08.02.2024.
//

import Foundation

enum SignInType {
    case favorites
    case community
    case example
    
    var title: String {
        switch self {
        case .favorites:
            return "Your favorites"
        case .community:
            return "Your communities"
        case .example:
            return "Your lovely books"
        }
    }
    
    var subtitle: String { "Anytime" }
    
    var description: String {
        switch self {
        case .favorites:
            return "Your favorites list is where you can find all the books that you particularly like. Enjoy reading and share your favorite books with friends."
        case .community:
            return "To find your community, chat and share book preferences, you must sign in to your account."
        case .example:
            return "The bookly app is a place where you can make new friends, share your favorite books, and discuss the latest releases."
        }
    }
}
