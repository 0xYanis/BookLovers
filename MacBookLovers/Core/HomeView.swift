//
//  HomeView.swift
//  MacBookLovers
//
//  Created by Yanis on 22.02.2024.
//

import SwiftUI
#warning("разработка невозможна, отсутствует требуемая версия macOS.")
struct HomeView: View {
    @State private var columnVisibility: NavigationSplitViewVisibility = .doubleColumn
    @State private var selectedOption: MenuOption = .explore
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            SideMenuView(isShowing: .constant(true), selectedOption: $selectedOption)
        } detail: {
            currentView(option: selectedOption)
        }
    }
    
    @ViewBuilder
    private func currentView(option: MenuOption) -> some View {
        switch option {
        case .explore:
            Text(option.title)
        case .profile:
            Text(option.title)
        case .communities:
            Text(option.title)
        default:
            Text(MenuOption.aboutUs.title)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
