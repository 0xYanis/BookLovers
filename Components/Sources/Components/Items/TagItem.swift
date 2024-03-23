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
        #if os(macOS)
        Text(title)
            .font(font)
            .padding(.horizontal, 6)
            .padding(6)
            .background(scheme == .dark ? .black : .white)
            .clipShape(RoundedRectangle(cornerRadius: 6))
        #else
        Text(title)
            .font(font)
            .padding(.horizontal, 6)
            .padding(6)
            .background(Color(uiColor: isDark ? .tertiarySystemBackground : .secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 6))
        #endif
    }
    
    private var isDark: Bool {
        scheme == .dark
    }
}
