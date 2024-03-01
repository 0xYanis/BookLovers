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
    
    @State private var offset = CGSize()
    @Namespace private var animation
    @Environment(\.colorScheme) private var scheme
    @EnvironmentObject private var userStore: UserStore
#if os(iOS)
    @EnvironmentObject private var coordinator: ExploreCoordinator
#endif
    var body: some View {
#if os(iOS)
        ZStack {
            if isShowing {
                sideMenu
            }
        }
        .animation(.spring(dampingFraction: 0.95), value: isShowing)
#else
        VStack(alignment: .leading, spacing: 32) {
            menuHeader
            menuList
            menuFooter
        }
        .frame(maxHeight: .infinity, alignment: .top)
#endif
    }
#if os(iOS)
    private var sideMenu: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 32) {
                menuHeader
                menuList
                menuFooter
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .frame(width: screen.width * 0.75, alignment: .leading)
            .background(Material.bar)
            .offset(x: offset.width < 0 ? offset.width : 0)
            Spacer()
        }
        .gesture(DragGesture()
            .onChanged(onChanged(_:))
            .onEnded(onEnded(_:))
        )
        .transition(.move(edge: .leading))
    }
#endif
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
#if os(iOS)
                coordinator.popToRoot()
#endif
            }
            .padding()
            
            VStack(alignment: .leading, spacing: 7) {
                Text("Appearence mode".uppercased())
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                Picker("Appearence mode", selection: $userStore.settings.colorScheme) {
                    ForEach(Mode.allCases) { mode in
                        Text(mode.title).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: userStore.settings.colorScheme) { newValue in
                    userStore.setAppearance(mode: newValue)
                }
            }
            .padding([.top, .horizontal])
        }
    }
    
    private func onChanged(_ gesture: DragGesture.Value) {
        if offset.width <= 0 {
            withAnimation(.interactiveSpring(response: 0.2, dampingFraction: 0.9)) {
                offset = gesture.translation
            }
        }
    }
    
    private func onEnded(_ gesture: DragGesture.Value) {
        if offset.width >= -50 {
            withAnimation(.interactiveSpring(response: 0.2, dampingFraction: 0.9)) {
                offset = .zero
            }
        }
        
        if offset.width < -50 {
            hideMenu()
        }
    }
    
    private func hideMenu() {
        withAnimation(.spring(dampingFraction: 0.95)) {
            isShowing = false
            offset = .zero
        }
    }
    
    private func optionTapped(_ option: MenuOption) {
        withAnimation(.easeInOut(duration: 0.2)) {
            selectedOption = option
#if os(iOS)
            hideMenu()
            coordinator.push(page: option)
#endif
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
        ExploreView()
            .environmentObject(UserStore())
    }
}
