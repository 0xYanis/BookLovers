//
//  DTOBookList.swift
//  BookLovers
//
//  Created by Yanis on 23.03.2024.
//

import Foundation

struct DTOBookList: Decodable {
    let totalItems: Int
    let items: [DTOBook]
}

struct DTOBook: Identifiable, Decodable {
    let id: String
    let bookInfo: DTOBookInfo
    let accessInfo: DTOBookAccessInfo
    
    enum CodingKeys: String, CodingKey {
        case id
        case bookInfo = "volumeInfo"
        case accessInfo
    }
}

struct DTOBookInfo: Decodable {
    let title: String?
    let authors: [String]?
    let publisher, publishedDate: String?
    let description: String?
    let pageCount: Int?
    let categories: [String]?
    let imageLinks: ImageLinks?
    let previewLink: String?
    let infoLink: String?
    
    struct ImageLinks: Decodable {
        let smallThumbnail, thumbnail: String?
    }
}

struct DTOBookAccessInfo: Decodable {
    let pdf: DTOBookPDF
}

struct DTOBookPDF: Decodable {
    let isAvailable: Bool
    let acsTokenLink: String?
}
