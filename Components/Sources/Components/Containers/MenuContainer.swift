//
//  MenuContainer.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

#if os(iOS)
public struct MenuContainer<Menu: View, Content: View>: View {
    @Binding private var isOpened: Bool
    private let menu: Menu
    private let content: Content
    
    public init(
        isOpened: Binding<Bool>,
        @ViewBuilder menu:  () -> Menu,
        @ViewBuilder content: () -> Content
    ) {
        _isOpened = isOpened
        self.menu = menu()
        self.content = content()
    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            content
            
            if isOpened {
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture { isOpened.toggle() }
                
                menu
                    .zIndex(1)
                    .toolbar(.hidden, for: .tabBar)
            }
        }
        .animation(.spring(), value: isOpened)
    }
}
#endif
