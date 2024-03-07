//
//  Avatar.swift
//  BookLovers
//
//  Created by Yanis on 07.03.2024.
//

import SwiftUI
import Kingfisher

struct Avatar: View {
    let url: URL?
    var body: some View {
        KFImage
            .url(url)
            .resizable()
            .placeholder { Image(systemName: "person.fill") }
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
    }
}
