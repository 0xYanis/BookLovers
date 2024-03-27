//
//  SearchCardView.swift
//  BookLovers
//
//  Created by Yanis on 27.03.2024.
//

import SwiftUI
import Kingfisher

fileprivate enum SearchCardOption: String, CaseIterable, Identifiable {
    case show = "Show details"
    case save = "Save to favorites"
    
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
    var action: () -> ()
    
    var body: some View {
        HStack(spacing: -25) {
            cardView
            .zIndex(1)
            
            imageView
                .zIndex(0)
        }
        .padding(.horizontal)
        //.onTapGesture(perform: action)
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
        .matchedGeometryEffect(id: book.id, in: animation)
        .contextMenu {
            ForEach(SearchCardOption.allCases) { option in
                Button(action: { optionTapped(option) }) {
                    Label(
                        option.rawValue,
                        systemImage: option.image
                    )
                }
            }
        }
    }
    
    var imageView: some View {
        KFImage(book.smallImage)
            .placeholder {ProgressView()}
            .resizable()
            .cacheMemoryOnly()
            .cancelOnDisappear(true)
            .scaledToFit()
            .frame(width: 120)
            .clipShape(RoundedRectangle(
                cornerRadius: 10,
                style: .continuous)
            )
    }
    
    private func optionTapped(_ option: SearchCardOption) {
        
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
