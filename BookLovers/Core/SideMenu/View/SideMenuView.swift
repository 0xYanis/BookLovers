//
//  SideMenuView.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isShowing: Bool
    @Binding var selectedOption: MenuOption
    @Environment(\.colorScheme) private var scheme
    
    var body: some View {
        ZStack {
            if isShowing {
                sideMenu
            }
        }
        .animation(.spring(dampingFraction: 0.95), value: isShowing)
    }
    
    private var background: some View {
        Rectangle()
            .opacity(0.0)
            .ignoresSafeArea()
            .onTapGesture { isShowing.toggle() }
    }
    
    private var sideMenu: some View {
        HStack {
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading) {
                    // header
                    SideMenuHeader()
                    
                    // menu
                    ForEach(MenuOption.allCases) { option in
                        Button {
                            optionTapped(option)
                        } label: {
                            SideMenuItem(
                                option: option,
                                selectedOption: $selectedOption
                            )
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .frame(width: 270, alignment: .leading)
            .background(scheme == .light ? .white : Color(UIColor.systemGray6))
            .onSwipe(left: { hideMenu() } )
            Spacer()
        }
        .transition(.move(edge: .leading))
    }
    
    private func hideMenu() {
        withAnimation(.spring(dampingFraction: 0.95)) {
            isShowing = false
        }
    }
    
    private func optionTapped(_ option: MenuOption) {
        withAnimation(.easeInOut(duration: 0.1)) {
            selectedOption = option
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.hideMenu()
            }
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowing: .constant(true), selectedOption: .constant(.explore))
    }
}
