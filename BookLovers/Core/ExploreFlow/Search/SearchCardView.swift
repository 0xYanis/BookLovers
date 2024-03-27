//
//  SearchCardView.swift
//  BookLovers
//
//  Created by Yanis on 27.03.2024.
//

import SwiftUI
import Kingfisher

fileprivate enum SearchCardMenu: String, CaseIterable, Identifiable {
    case show = "show details"
    case save = "save to favorites"
    
    var id: String { rawValue }
    var image: String {
        switch self {
        case .show: return "book"
        case .save: return "heart"
        }
    }
}

struct SearchCardView: View {
    var book: Book
    var animation: Namespace.ID
    
    var body: some View {
        Menu {
            ForEach(SearchCardMenu.allCases) { item in
                Button {
                    
                } label: {
                    Label(
                        item.rawValue.capitalized,
                        systemImage: item.image
                    )
                }
            }
        } label: {
            HStack(spacing: -25) {
                cardView
                .padding()
                .frame(height: 120)
                .background {
                    RoundedRectangle(
                        cornerRadius: 10,
                        style: .continuous
                    )
                    .fill(Color(.tertiarySystemBackground))
                }
                .shadow(color: .black.opacity(0.15), radius: 15)
                .zIndex(1)
                
                imageView
                    .frame(width: 120)
                    .clipShape(RoundedRectangle(
                        cornerRadius: 10,
                        style: .continuous)
                    )
                    .zIndex(0)
            }
        }
        .padding(.horizontal)
    }
    
    var cardView: some View {
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
        .matchedGeometryEffect(id: book.id, in: animation)
    }
    
    var imageView: some View {
        KFImage(book.smallImage)
            .placeholder {ProgressView()}
            .resizable()
            .cacheMemoryOnly()
            .cancelOnDisappear(true)
            .scaledToFit()
            .matchedGeometryEffect(id: book.id, in: animation)
    }
}

struct SearchCardView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

extension Float {
    func toString(arg: String) -> String {
        return String(format: arg, self)
    }
}
