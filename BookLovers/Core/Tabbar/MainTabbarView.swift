//
//  MainTabbarView.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI
import Managers
import AlertKit

struct MainTabbarView: View {
    @State private var showNetworkAlert = false
    @State private var selectedTab: TabItem = .explore
    @StateObject private var network = NetworkManager()
    @EnvironmentObject private var userStore: UserStore
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(TabItem.allCases, content: tabView(_:))
        }
        .onChange(of: network.isConnected, perform: showAlert(_:))
    }
    
    @ViewBuilder
    private func tabView(_ item: TabItem) -> some View {
        item.view
            .alertToast(
                isPresented: $showNetworkAlert,
                systemImage: "wifi.slash",
                text: "No internet connection",
                haptic: .warning
            )
            .tag(item)
            .tabItem {
                #if os(iOS)
                Image(uiImage: item.uiImage(selected: selectedTab))
                #else
                Image(systemName: item.image)
                #endif
                Text(item.name)
            }
            .badge(item == .community ? userStore.user.messages : 0)
    }
    
    private func showAlert(_ state: Bool) {
        showNetworkAlert = (state == false)
    }
}

struct MainTabbarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabbarView()
            .environmentObject(UserStore())
    }
}
