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

enum FullScreenCover: String, Identifiable {
    case aboutDev
    
    var id: String {
        return self.rawValue
    }
}

enum Sheet: String, Identifiable {
    case onboarding
    
    var id: String {
        return self.rawValue
    }
}

final class FlowManager: ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    
    private var authManager: AuthManager
    
    init(authManager: AuthManager = AuthManagerImpl()) {
        self.authManager = authManager
    }
    
    // MARK: - Manager methods
    
    func start(flow: Flow) {
        path.append(flow)
    }
    
    func finishFlow() {
        path.removeLast()
    }
    
    func finishAllFlows() {
        path.removeLast(path.count)
    }
    
    func present(sheet: Sheet) {
        self.sheet = sheet
    }
    
    func present(fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }
     
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
    
    // MARK: - SwiftUI ViewBuilders
    
    @ViewBuilder
    func build(flow: Flow) -> some View {
        switch flow {
        case .auth:
            EmptyView()
        case .home:
            HomeView()
        case .community:
            EmptyView()
        }
    }
    
    @ViewBuilder
    func build(sheet: Sheet) -> some View {
        switch sheet {
        case .onboarding:
            EmptyView()
        }
    }
    
    @ViewBuilder
    func build(fullScreenCover: FullScreenCover) -> some View {
        switch fullScreenCover {
        case .aboutDev:
            EmptyView()
        }
    }
}
