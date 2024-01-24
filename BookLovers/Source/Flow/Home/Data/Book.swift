//
//  Book.swift
//  BookLovers
//
//  Created by Yanis on 24.01.2024.
//

import Foundation

struct Book: Identifiable, Decodable {
    let id: String
    let etag: String
    let selfLink: String
    let volumeInfo: BookVolumeInfo
}
