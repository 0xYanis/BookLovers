//
//  BubbleItem.swift
//  BookLovers
//
//  Created by Yanis on 16.02.2024.
//

import SwiftUI

struct BubbleItem: View {
    let message: String?
    let image: String?
    let myMessage: Bool
    
    var body: some View {
        if message == nil && image == nil {
            Color.clear
        } else {
            VStack(alignment: .leading, spacing: 5) {
                if image != nil {
                    imageMessage
                }
                
                if message != nil {
                    textMessage
                }
            }
            .overlay(alignment: .bottomTrailing) {
                Text("11:35")
                    .foregroundStyle(.secondary)
                    .font(.footnote)
                    .offset(y: 13)
                    .padding(.horizontal, 10)
            }
            .padding(myMessage ? .trailing : .leading, 5)
            .padding(.bottom)
            .background(Color.green.gradient)
            .clipShape(BubbleShape(myMessage: myMessage))
            .frame(width: screen.width * 0.8)
        }
    }
    
    private var textMessage: some View {
        Text(message ?? "")
            .font(.callout)
            .padding(.horizontal, 10)
            .foregroundStyle(.white)
    }
    
    private var imageMessage: some View {
        Image(image ?? "")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: screen.width * 0.8)
            .clipShape(CustomCornersShape(corners: [.topLeft, .topRight], radius: 15))
            .padding([.horizontal, .top], 2)
    }
    
}

struct BubbleItem_Previews: PreviewProvider {
    static var previews: some View {
        BubbleItem(message: "Look! My favorite book!", image: "book1", myMessage: true)
    }
}
