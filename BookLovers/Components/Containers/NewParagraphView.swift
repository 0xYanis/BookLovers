//
//  TitleView.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

struct NewParagraphView<Content: View, TopItem: View>: View {
    private let title: String
    private let content: Content
    private let topItem: TopItem
    
    init(
        title: String,
        @ViewBuilder content: () -> Content,
        @ViewBuilder topItem: () -> TopItem = { EmptyView() }
    ) {
        self.title = title
        self.content = content()
        self.topItem = topItem()
    }
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                Spacer()
                
                topItem
            }
            .padding(.horizontal)
            
            content
                .padding(.bottom, 10)
        }
    }
}
