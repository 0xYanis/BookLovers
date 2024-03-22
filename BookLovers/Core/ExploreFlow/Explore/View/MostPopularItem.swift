//
//  MostPopularItem.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI
import Components

struct MostPopularItem: View {
    let background: Color
    
    init(background: Color = .systemBackground) {
        self.background = background
    }
    
    var body: some View {
        HStack(alignment: .top) {
            DefaultImageView()
            description.padding(5)
        }
        .background(background)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var description: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("The Master and Margarita")
                .font(.headline)
                .fontWeight(.semibold)
            
            HStack(spacing: 4) {
                Text("by")
                    .font(.caption)
                Text("Mikhail Bulgakov")
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            
            rating
            
            Text(
"""
The novel is set in Moscow and tells the story of the devil Woland and his entourage, who arrive in the city and cause chaos. The story is intertwined with the story of the Master, a writer who has written a novel about Pontius Pilate, and Margarita, a woman who makes a deal with the devil to find her beloved Master.

"""
            )
            .lineLimit(5)
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
            Text("4.9")
                .font(.callout)
                .foregroundStyle(.gray)
        }
    }
}

struct MostPopularItem_Previews: PreviewProvider {
    static var previews: some View {
        MostPopularItem()
            .frame(height: 150)
            .padding()
    }
}
