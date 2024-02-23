//
//  FavoriteItem.swift
//  BookLovers
//
//  Created by Yanis on 14.02.2024.
//

import SwiftUI

struct FavoriteItem: View {
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            image
                .padding([.leading, .vertical])
            
            VStack(alignment: .leading) {
                titleLabel
                    .padding(.top)
                
                secondaryLabel(text: "Michail Bulgacov")
                
                Spacer()
                
                HStack(spacing: 0) {
                    secondaryLabel(text: "Pages 150/300")
                    Spacer()
                    secondaryLabel(text: "50%")
                }
                
                statusLine
                    .padding(.bottom)
            }
            .padding(.trailing)
        }
        .frame(height: screen.height / 7)
        .background(Color(uiColor: .secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var image: some View {
        Image("book1")
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var titleLabel: some View {
        Text("The Master and Margarita")
            .font(.subheadline)
            .fontWeight(.semibold)
    }
    
    private var statusLine: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .fill(Color.green.opacity(0.1))
                .frame(maxWidth: .infinity)
                .frame(height: 8)
            Capsule()
                .fill(Color.green)
                .frame(width: 150)
                .frame(height: 8)
        }
    }
    
    private func secondaryLabel(text: String) -> some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(.secondary)
    }
}

struct FavoriteItem_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteItem()
    }
}
