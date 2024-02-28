//
//  BigButton.swift
//  BookLovers
//
//  Created by Yanis on 09.02.2024.
//

import SwiftUI

public struct BigButton: View {
    private let title: String
    private let cornerRadius: CGFloat
    private let color: Color
    private let action: () -> Void
    
    public init(
        title: String,
        cornerRadius: CGFloat = 12,
        color: Color = .green,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.cornerRadius = cornerRadius
        self.color = color
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) { Text(title) }
        .foregroundStyle(.white)
        .fontWeight(.semibold)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(color)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}
