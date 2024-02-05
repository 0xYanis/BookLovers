//
//  MenuContainer.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

struct MenuContainer<Menu: View, Content: View>: View {
    @Binding private var isOpened: Bool
    private let menu: Menu
    private let content: Content
    
    init(
        isOpened: Binding<Bool>,
        @ViewBuilder menu:  () -> Menu,
        @ViewBuilder content: () -> Content
    ) {
        _isOpened = isOpened
        self.menu = menu()
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            content
            
            if isOpened {
                menu
                    .transition(.move(edge: .leading))
                    .zIndex(1)
                    .toolbar(.hidden, for: .tabBar)
            }
        }
        .animation(.spring(), value: isOpened)
    }
}
