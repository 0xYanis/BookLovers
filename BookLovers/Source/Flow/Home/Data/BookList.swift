//
//  BookList.swift
//  BookLovers
//
//  Created by Yanis on 24.01.2024.
//

import Foundation

struct BookList: Decodable {
    let kind: String
    let totalItems: Int
    let items: [Book]
}
