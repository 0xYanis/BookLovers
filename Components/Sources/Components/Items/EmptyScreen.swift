//
//  EmptyScreen.swift
//  
//
//  Created by Yanis on 24.03.2024.
//

import SwiftUI

public struct EmptyScreen: View {
    private let title: String
    private let subtitle: String
    private let systemImage: String
    
    public init(title: String, subtitle: String, systemImage: String) {
        self.title = title
        self.subtitle = subtitle
        self.systemImage = systemImage
    }
    
    public var body: some View {
        VStack(spacing: 32) {
            Image(systemName: systemImage)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.gray)
                .frame(width: 52, height: 52)
                .padding()
            VStack(spacing: 12) {
                Text(title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                Text(subtitle)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 32)
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
    }
}
