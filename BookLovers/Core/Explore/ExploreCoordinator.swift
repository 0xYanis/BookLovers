//
//  ExploreCoordinator.swift
//  BookLovers
//
//  Created by Yanis on 15.02.2024.
//

import SwiftUI

final class ExploreCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(page: MenuOption) {
        if page != .explore {
            path.append(page)
        }
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func build(page: MenuOption) -> some View {
        Text(page.title)
            .tag(page)
            .navigationTitle(page.title)
    }
}
