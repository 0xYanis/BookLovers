//
//  RectImage.swift
//  BookLovers
//
//  Created by Yanis on 19.02.2024.
//

import SwiftUI

public struct RectImage: View {
    private let systemImage: String
    private let color: Color
    private let width: CGFloat
    
    public init(systemImage: String, color: Color, width: CGFloat) {
        self.systemImage = systemImage
        self.color = color
        self.width = width
    }
    
    public var body: some View {
        Image(systemName: systemImage)
            .foregroundStyle(.white)
            .padding(5)
            .frame(width: width * 0.075, height: width * 0.075)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 7))
    }
}
