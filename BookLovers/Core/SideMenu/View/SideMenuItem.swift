//
//  SideMenuItem.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

struct SideMenuItem: View {
    var option: MenuOption
    @Binding var selectedOption: MenuOption
    @Environment(\.colorScheme) private var scheme
    
    var body: some View {
        HStack {
            Image(systemName: option.image)
                .imageScale(.small)
            Text(option.title)
                .font(.subheadline)
            Spacer()
        }
        .padding(.leading)
        .foregroundStyle(isSelected ? .blue : .primary)
        .frame(width: 216, height: 44)
        .background(isSelected ? Color.accentColor.opacity(0.15) : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private var isSelected: Bool {
        selectedOption == option
    }
}
