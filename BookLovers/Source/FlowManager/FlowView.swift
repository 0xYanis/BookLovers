//
//  FlowView.swift
//  BookLovers
//
//  Created by Yanis on 24.01.2024.
//

import SwiftUI

struct FlowView: View {
    @StateObject private var flowManager = FlowManager()
    
    var body: some View {
        NavigationStack(path: $flowManager.path) {
            flowManager.build(flow: .auth)
            .navigationDestination(for: Flow.self) { newFlow in
                flowManager.build(flow: newFlow)
            }
        }
    }
}
