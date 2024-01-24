//
//  BookVolumeInfo.swift
//  BookLovers
//
//  Created by Yanis on 24.01.2024.
//

import Foundation

struct BookVolumeInfo: Decodable {
    let title: String
    let subtitle: String?
    let authors: [String]
    let publisher, publishedDate, description: String
    let pageCount: Int?
    let categories: [Category]
    let allowAnonLogging: Bool
    let contentVersion: String
    let imageLinks: ImageLinks
    let language: Language
    let previewLink: String
    let infoLink: String
    let canonicalVolumeLink: String
    let averageRating, ratingsCount: Int?
    
    struct ImageLinks: Decodable {
        let smallThumbnail, thumbnail: String
    }
    
    enum Language: String, Decodable {
        case en = "en"
    }
    
    enum Category: String, Decodable {
        case computers = "Computers"
    }
}
