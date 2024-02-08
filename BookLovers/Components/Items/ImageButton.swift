//
//  ImageButton.swift
//  BookLovers
//
//  Created by Yanis on 07.02.2024.
//

import SwiftUI

struct ImageButton: View {
    var systemImage: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.title2)
                .foregroundStyle(.secondary)
        }
        .buttonStyle(.plain)
    }
}
