//
//  SearchCardView.swift
//  BookLovers
//
//  Created by Yanis on 27.03.2024.
//

import SwiftUI
import Kingfisher

struct SearchCardView: View {
    var book: Book
    
    var body: some View {
        HStack(spacing: -25) {
            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .top, spacing: 4) {
                    Text(book.title)
                        .font(.headline)
                    Spacer()
                    Text("\(Float.random(in: 3...5).toString(arg: "%.2f"))")
                        .font(.subheadline)
                    Image(systemName: "star.fill")
                        .font(.subheadline)
                        .foregroundStyle(.yellow)
                }
                
                Text("by: \(book.authors)")
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                HStack {
                    Text(book.publishedDate)
                        .font(.caption)
                        .foregroundStyle(.gray)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.callout)
                        .foregroundStyle(.green)
                }
            }
            .padding()
            .frame(height: 120)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(.tertiarySystemBackground))
            }
            .shadow(color: .black.opacity(0.15), radius: 15)
            .zIndex(1)
            
            KFImage(book.smallImage)
                .placeholder {ProgressView()}
                .resizable()
                .cacheMemoryOnly()
                .cancelOnDisappear(true)
                .scaledToFit()
                .frame(width: 120)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .zIndex(0)
        }
        .padding(.horizontal)
    }
}

struct SearchCardView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCardView(book: .preview)
    }
}

extension Float {
    func toString(arg: String) -> String {
        return String(format: arg, self)
    }
}
