//
//  CurrentTabEnvKey.swift
//  BookLovers
//
//  Created by Yanis on 20.03.2024.
//

import SwiftUI

struct CurrentTabEnvKey: EnvironmentKey {
    static let defaultValue: Binding<TabItem> = .constant(.explore)
}

extension EnvironmentValues {
    /// Сurrent tabbar screen.
    var currentTab: Binding<TabItem> {
        get { self[CurrentTabEnvKey.self] }
        set { self[CurrentTabEnvKey.self] = newValue }
    }
}
