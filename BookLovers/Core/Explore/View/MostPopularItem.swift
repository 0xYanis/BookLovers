//
//  MostPopularItem.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

struct MostPopularItem: View {
    var body: some View {
        HStack(alignment: .top) {
            Image("book1")
                .resizable()
                .scaledToFit()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Master and Margarita")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                HStack(spacing: 4) {
                    Text("by")
                        .font(.caption)
                    Text("Mikhail Bulgakov")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                
                HStack(spacing: 2) {
                    ForEach(1...5, id: \.self) { item in
                        Image(systemName: "star.fill")
                            .imageScale(.small)
                            .foregroundStyle(.yellow)
                    }
                }
                
                Text(
"""
The novel is set in Moscow and tells the story of the devil Woland and his entourage, who arrive in the city and cause chaos. The story is intertwined with the story of the Master, a writer who has written a novel about Pontius Pilate, and Margarita, a woman who makes a deal with the devil to find her beloved Master.

"""
                )
                .lineLimit(3)
                .font(.caption2)
                .foregroundStyle(.secondary)
            }
            .padding(5)
        }
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.1), radius: 10)
    }
}

struct MostPopularItem_Previews: PreviewProvider {
    static var previews: some View {
        MostPopularItem()
    }
}
