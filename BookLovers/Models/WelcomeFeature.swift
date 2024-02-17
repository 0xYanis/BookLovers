//
//  WelcomeFeature.swift
//  BookLovers
//
//  Created by Yanis on 09.02.2024.
//

import SwiftUI

enum WelcomeMessage: String {
    case first = "Сommunicate"
    case second = "Еxplore the book world"
    case third = "Expand your horizons"
}

struct WelcomeFeature: Identifiable {
    var id = UUID().uuidString
    let image: String
    let color: Color = Color.randomColor()
    let title: String
    let subtitle: String
    
    static let firstScreen: [WelcomeFeature] = [
        .init(image: "person.2.circle", title: "User Profiles", subtitle: "Create an account, add information about your favorite books, interests, and exchange messages with other readers."),
        .init(image: "person.3", title: "Groups and Discussions", subtitle: "Create or join groups with different book topics, authors, or genres to discuss and share recommendations."),
        .init(image: "list.star", title: "Ratings and reviews", subtitle: "The ability to rate books, write reviews, share impressions and recommendations with other users.")
    ]
    static let secondScreen: [WelcomeFeature] = [
        .init(image: "calendar.badge.clock", title: "Organizing Events", subtitle: "Features creating and joining book events, meetups, or book clubs in the real world."),
        .init(image: "square.and.arrow.up", title: "Book sharing", subtitle: "The ability to exchange or gift books to other users within the application."),
        .init(image: "bell", title: "New Release Notifications", subtitle: "Alerts you to new book releases, events, or promotions related to your favorite genres or authors.")
    ]
    static let thirdScreen: [WelcomeFeature] = [
        .init(image: "ellipsis.bubble", title: "Chat and private messages", subtitle: "The ability to communicate in real time with other readers, exchange private messages and organize chats."),
        .init(image: "bookmark.square", title: "Book Recommendations", subtitle: "Personalized book recommendations based on user preferences, ratings, and reviews."),
        .init(image: "pencil.and.list.clipboard", title: "Wishlists", subtitle: "The ability to create a wish list, mark books you've already read, organize your book collection, and track your reading progress.")
    ]
}


extension Color {
    static func randomColor() -> Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(red: red, green: green, blue: blue, opacity: 1.0)
    }
}
