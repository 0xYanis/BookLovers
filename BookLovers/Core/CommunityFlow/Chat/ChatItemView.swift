//
//  ChatItemView.swift
//  BookLovers
//
//  Created by Yanis on 15.02.2024.
//

import SwiftUI

struct ChatItemView: View {
    let avatar: String
    let name: String
    let message: String
    let time: Date
    let isRead: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0, content: chatItem)
    }
    
    private func chatItem() -> some View {
        HStack(alignment: .top, spacing: 0) {
            personImage
            personMessage
        }
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var personImage: some View {
        Image(avatar)
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 60)
            .clipShape(Circle())
            .padding(.trailing, 10)
    }
    
    private var messageContent: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(name)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
            Spacer()
            Text(message)
                .font(.footnote)
                .foregroundStyle(.gray)
                .lineLimit(2)
        }
    }
    
    private var messageSubcontent: some View {
        VStack(alignment: .trailing, spacing: 0) {
            HStack(spacing: 5) {
                Image(systemName: "checkmark")
                    .imageScale(.small)
                    .foregroundStyle(isRead ? .green : .gray)
                Text(time.formatted(date: .omitted, time: .shortened))
                    .foregroundStyle(.gray)
            }
        }
    }
    
    private var personMessage: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                messageContent
                messageSubcontent
            }
            Divider()
        }
    }
}
