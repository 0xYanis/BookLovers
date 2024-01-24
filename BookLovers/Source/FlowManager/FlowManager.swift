//
//  FlowManager.swift
//  BookLovers
//
//  Created by Yanis on 24.01.2024.
//

import SwiftUI

enum Flow: Hashable {
    case auth
    case home
    case community
}

final class FlowManager: ObservableObject {
    @Published var path = NavigationPath()
    
    func start(flow: Flow) {
        path.append(flow)
    }
    
    func finishFlow() {
        path.removeLast()
    }
    
    func finishAllFlows() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func build(flow: Flow) -> some View {
        switch flow {
        case .auth:
            EmptyView()
        case .home:
            EmptyView()
        case .community:
            EmptyView()
        }
    }
}
