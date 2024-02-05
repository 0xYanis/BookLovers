//
//  ExploreView.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                ExploreHeader()
                    .padding()
                Rectangle()
                    .foregroundStyle(.secondary.opacity(0.4))
                    .frame(maxWidth: .infinity)
            }
            .toolbar {
                // 3lines
                leadingItem
                // avatar
                trailingItem
            }
        }
    }
    
    private var leadingItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: leadingItemAction) {
                Image(systemName: "line.3.horizontal")
            }
            .buttonStyle(.plain)
        }
    }
    
    private var trailingItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: trailingItemAction) {
                Image("avatar")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30)
                    .clipShape(Circle())
            }
        }
    }
    
    private func leadingItemAction() {
        
    }
    
    private func trailingItemAction() {
        
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
