//
//  TrendingBooksGridView.swift
//  BookLovers
//
//  Created by Yanis on 07.02.2024.
//

import SwiftUI

struct TrendingBooksGridView: View {
    private var gridItems: [GridItem]
    private var spacing: CGFloat
    
    init(columns: Int = 3, spacing: CGFloat = 40) {
        self.gridItems = Array(
            repeating: GridItem(.flexible(), spacing: spacing * 0.7),
            count: columns)
        self.spacing = spacing
    }
    
    var body: some View {
        LazyVGrid(
            columns: gridItems,
            alignment: .center,
            spacing: spacing
        ) {
            ForEach(0..<9, id: \.self) { item in
                VStack(alignment: .leading, spacing: 3) {
                    Image("book1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    VStack(alignment: .leading, spacing: 3) {
                        HStack(alignment: .top) {
                            Text("Bulgacov")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                            Spacer()
                            
                            Text("4.67")
                                .font(.caption2)
                        }
                        
                        Text("The Master and Margarita")
                            .font(.caption)
                            .lineLimit(1)
                    }
                }
                .clipShape(CustomCornersShape(
                    corners: [.topRight, .topLeft],
                    radius: 10))
            }
        }
    }
}

struct TrendingBooksGridView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ScrollView {
                TrendingBooksGridView()
            }
            .navigationTitle("Books")
        }
    }
}
