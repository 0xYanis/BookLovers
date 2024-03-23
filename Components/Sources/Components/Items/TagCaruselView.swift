//
//  TagCaruselView.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

public struct TagCaruselView: View {
    private let tags: [String]
    private let font: Font
    private let onTap: (_ id: Int) -> Void
    
    public init(
        tags: [String],
        font: Font = .body,
        onTap: @escaping (_ id: Int) -> Void
    ) {
        self.tags = tags
        self.font = font
        self.onTap = onTap
    }
    
    public var body: some View {
        HStack {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<tags.count, id: \.self) { i in
                            TagItem(title: tags[i], font: font)
                                .onTapGesture {
                                    withAnimation { proxy.scrollTo(i, anchor: .center) }
                                    onTap(i)
                                }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}
