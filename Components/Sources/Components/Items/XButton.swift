//
//  XButton.swift
//  BookLovers
//
//  Created by Yanis on 07.02.2024.
//

import SwiftUI

public struct XButton: View {
    private let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: "xmark.circle.fill")
                .font(.title2)
                .foregroundStyle(.secondary)
        }
        .buttonStyle(.plain)
    }
}
