//
//  ChatItemView.swift
//  BookLovers
//
//  Created by Yanis on 15.02.2024.
//

import SwiftUI

struct ChatItemView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                Image("avatar")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .padding(.trailing, 10)
                
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Yanis Rybkin")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.headline)
                            Spacer()
                            Text("Hello world! Let's read some \nBulgacov staff!")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                                .lineLimit(2)
                        }
                        
                        VStack(alignment: .trailing, spacing: 0) {
                            HStack(spacing: 5) {
                                Image(systemName: "checkmark")
                                    .imageScale(.small)
                                    .foregroundStyle(.green)
                                Text("29.01.2024")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    
                    Divider()
                }
            }
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
