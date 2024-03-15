//
//  ImageButton.swift
//  BookLovers
//
//  Created by Yanis on 07.02.2024.
//

import SwiftUI

public struct ImageButton: View {
    private var systemImage: String
    private let action: () -> Void
    
    public init(systemImage: String, action: @escaping () -> Void) {
        self.systemImage = systemImage
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.title2)
                .foregroundStyle(.gray)
        }
        .buttonStyle(.plain)
    }
}
