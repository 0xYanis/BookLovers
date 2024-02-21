//
//  SideMenuView.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isShowing: Bool
    @Namespace private var animation
    @Binding var selectedOption: MenuOption
    
    @Environment(\.colorScheme) private var scheme
    @EnvironmentObject private var coordinator: ExploreCoordinator
    @EnvironmentObject private var userStore: UserStore
    
    var body: some View {
        if UIDevice.isiPhone {
            ZStack {
                if isShowing {
                    sideMenu
                }
            }
            .animation(.spring(dampingFraction: 0.95), value: isShowing)
        } else {
            VStack(alignment: .leading, spacing: 32) {
                menuHeader
                menuList
                menuFooter
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
    private var sideMenu: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 32) {
                menuHeader
                menuList
                menuFooter
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .frame(width: screen.width * 0.75, alignment: .leading)
            .background(scheme == .light ? .white : Color(UIColor.systemGray6))
            .onSwipe(left: { hideMenu() } )
            Spacer()
        }
        .transition(.move(edge: .leading))
        .onSwipe(left: {
            isShowing = false
        })
    }
    
    private var menuHeader: some View {
        SideMenuHeader()
            .padding(.horizontal)
    }
    
    private var menuList: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(MenuOption.allCases) { option in
                Button {
                    optionTapped(option)
                } label: {
                    SideMenuItem(
                        option: option,
                        selectedOption: $selectedOption,
                        animation: animation
                    )
                }
            }
        }
        .padding(.trailing)
    }
    
    private var menuFooter: some View {
        VStack(alignment: .leading) {
            Divider()
            
            defaultButton("Log out", image: "door.left.hand.open") {
                userStore.setStatus(isAuthenticated: false)
                coordinator.popToRoot()
            }
            .padding()
        }
    }
    
    private func hideMenu() {
        withAnimation(.spring(dampingFraction: 0.95)) {
            isShowing = false
        }
    }
    
    private func optionTapped(_ option: MenuOption) {
        withAnimation(.easeInOut(duration: 0.2)) {
            selectedOption = option
            if UIDevice.isiPhone {
                hideMenu()
                coordinator.push(page: option)
            }
        }
    }
    
    private func defaultButton(
        _ title: String,
        image: String,
        action: @escaping () -> ()
    ) -> some View {
        Button(action: action) {
            HStack(spacing: 15) {
                Image(systemName: image)
                    .font(.body)
                    .frame(width: 30)
                
                Text(title)
                    .font(.callout)
            }
        }
        .foregroundStyle(.primary)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowing: .constant(true), selectedOption: .constant(.explore))
            .environmentObject(UserStore())
    }
}
