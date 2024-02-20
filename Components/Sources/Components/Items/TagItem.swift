//
//  TagItem.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

public struct TagItem: View {
    private let title: String
    private let font: Font
    
    @Environment(\.colorScheme) private var scheme
    
    public init(
        title: String,
        font: Font
    ) {
        self.title = title
        self.font = font
    }
    
    public var body: some View {
        Text(title)
            .font(font)
            .padding(.horizontal, 6)
            .padding(6)
            .background(Color(uiColor: isDark ? .tertiarySystemBackground : .white))
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
    
    private var isDark: Bool {
        scheme == .dark
    }
}
