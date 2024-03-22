//
//  FavoriteItem.swift
//  BookLovers
//
//  Created by Yanis on 14.02.2024.
//

import SwiftUI
import Components

struct FavoriteItem: View {
    var book: FavoriteBook
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            image
                .padding([.leading, .vertical])
            
            VStack(alignment: .leading) {
                titleLabel
                    .padding(.top)
                
                secondaryLabel(text: book.author)
                
                Spacer()
                
                HStack(spacing: 0) {
                    secondaryLabel(text: "Pages \(book.currentPage) / \(book.pages)")
                    Spacer()
                    secondaryLabel(text: "\(book.percent) %")
                }
                
                statusLine
                    .padding(.bottom)
            }
            .padding(.trailing)
        }
        .frame(height: 130)
        .background(Color(uiColor: .secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var image: some View {
        DefaultImageView()
            .frame(width: 75)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var titleLabel: some View {
        Text(book.title)
            .font(.subheadline)
            .fontWeight(.semibold)
    }
    
    private var statusLine: some View {
        ProgressLine(
            total: CGFloat(book.pages),
            value: CGFloat(book.currentPage)
        )
    }
    
    private func secondaryLabel(text: String) -> some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(.gray)
    }
}

struct FavoriteItem_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteItem(book: .preview.first!)
    }
}
