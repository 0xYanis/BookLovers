//
//  MostPopularItem.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI
import Components
import Kingfisher

struct MostPopularItem: View {
    private let book: Book
    private let background: Color
    
    init(book: Book, background: Color = .systemBackground) {
        self.book = book
        self.background = background
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            KFImage(book.smallImage)
                .placeholder(DefaultImageView.init)
                .resizable()
                .cacheMemoryOnly()
                .scaledToFit()
                .frame(width: 100)
                .clipped()
            
            description
                .padding(5)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(background)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var description: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(book.title)
                .lineSpacing(0)
                .font(.subheadline)
                .fontWeight(.semibold)
            
            HStack(spacing: 4) {
                Text("by")
                    .font(.caption)
                    .lineLimit(1)
                Text(book.authors)
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            
            rating
            
            Text(book.description)
            .lineLimit(3)
            .font(.caption2)
            .foregroundStyle(.gray)
        }
    }
    
    private var rating: some View {
        HStack(spacing: 2) {
            ForEach(1...5, id: \.self) { item in
                Image(systemName: "star.fill")
                    .imageScale(.small)
                    .foregroundStyle(.yellow)
            }
            Spacer()
            Text("4.9")
                .font(.callout)
                .foregroundStyle(.gray)
        }
    }
}

struct MostPopularItem_Previews: PreviewProvider {
    static var previews: some View {
        MostPopularItem(book: .preview)
            .frame(height: 150)
            .padding()
    }
}
