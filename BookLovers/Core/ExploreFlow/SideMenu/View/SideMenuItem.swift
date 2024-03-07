//
//  SideMenuItem.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI
import Components

struct SideMenuItem: View {
    var option: MenuOption
    @Binding var selectedOption: MenuOption
    var animation: Namespace.ID
    @Environment(\.colorScheme) private var scheme
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: option.image)
                .font(.body)
                .frame(width: 30)
            
            Text(option.title)
                .font(.callout)
                .fontWeight(isSelected ? .bold : .regular)
        }
        .foregroundStyle(isSelected ? .white : .primary)
        .padding(.vertical, 12)
        .padding(.horizontal)
        .frame(maxWidth: screen.width * 0.7, alignment: .leading)
        .background(background)
    }
    
    private var isSelected: Bool {
        selectedOption == option
    }
    
    private var background: some View {
        ZStack {
            if isSelected {
                #if os(macOS)
                Color.green
                    .opacity(isSelected ? 1 : 0)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .matchedGeometryEffect(id: "MENUOPTION", in: animation)
                #else
                Color.green
                    .opacity(isSelected ? 1 : 0)
                    .clipShape(CustomCornersShape(
                        corners: [.topRight, .bottomRight],
                        radius: 12))
                    .matchedGeometryEffect(id: "MENUOPTION", in: animation)
                #endif
            }
        }
    }
}

struct SideMenuItem_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(
            isShowing: .constant(true),
            selectedOption: .constant(.profile),
            navigationPath: .constant(.init())
        )
    }
}
