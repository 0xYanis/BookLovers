//
//  TagCaruselView.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

struct TagCaruselView: View {
    private let tags: [String]
    private let font: Font
    private let onTap: (_ id: Int) -> Void
    
    init(tags: [String], font: Font = .body, onTap: @escaping (_ id: Int) -> Void) {
        self.tags = tags
        self.font = font
        self.onTap = onTap
    }
    
    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<tags.count, id: \.self) { i in
                        TagItem(title: tags[i], font: font)
                            .onTapGesture { onTap(i) }
                    }
                }
                .padding(.horizontal)
            }
            .shadow(color: .black.opacity(0.1), radius: 4)
        }
    }
}

struct TagCaruselView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
