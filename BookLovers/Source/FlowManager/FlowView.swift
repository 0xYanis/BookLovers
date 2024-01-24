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
            flowManager.build(flow: .home)
                .navigationDestination(for: Flow.self) { newFlow in
                    flowManager.build(flow: newFlow)
                }
                .sheet(item: $flowManager.sheet) { sheet in
                    flowManager.build(sheet: sheet)
                }
                .fullScreenCover(item: $flowManager.fullScreenCover) { fullScreenCover in
                    flowManager.build(fullScreenCover: fullScreenCover)
                }
        }
        .environmentObject(flowManager)
    }
}
