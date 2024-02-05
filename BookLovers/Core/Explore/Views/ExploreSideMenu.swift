//
//  ExploreSideMenu.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

struct ExploreSideMenu: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            if isShowing {
                // background view (explore view)
                background
                
                // side menu view
                sideMenu
            }
        }
        .animation(.spring(dampingFraction: 0.95), value: isShowing)
    }
    
    private var background: some View {
        Rectangle()
            .opacity(0.3)
            .ignoresSafeArea()
            .onTapGesture { isShowing.toggle() }
    }
    
    private var sideMenu: some View {
        VStack {
            
        }
    }
}

struct ExploreSideMenu_Previews: PreviewProvider {
    static var previews: some View {
        ExploreSideMenu(isShowing: .constant(true))
    }
}
