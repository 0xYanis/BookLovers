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
            .placeholder(placeholder)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
    }
    
    private func placeholder() -> some View {
        Image(systemName: "person.fill")
            .resizable()
    }
}

struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditorView().environmentObject(UserStore())
    }
}
