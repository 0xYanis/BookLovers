//
//  ProgressLine.swift
//  BookLovers
//
//  Created by Yanis on 22.03.2024.
//

import SwiftUI

public struct ProgressLine: View {
    private let color: Color
    private let total: CGFloat
    private let value: CGFloat
    private let height: CGFloat
    
    public init(
        color: Color = .green,
        total: CGFloat,
        value: CGFloat,
        height: CGFloat = 8
    ) {
        self.color = color
        self.total = total
        self.value = value
        self.height = height
    }
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(color.opacity(0.1))
                    .frame(maxWidth: .infinity)
                    .frame(height: height)
                Capsule()
                    .fill(color)
                    .frame(width: proxy.size.width * value / total)
                    .frame(height: height)
            }
        }
    }
}
