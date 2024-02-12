//
//  FavoritesView.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

enum FavoriteType: String, CaseIterable, Identifiable {
    case onReading = "On reading"
    case readingList = "Reading list"
    case archived = "Archived"
    
    var id: String { rawValue }
}

struct FavoritesView: View {
    @State private var selectedType: FavoriteType = .onReading
    @State private var tabProgress: CGFloat = 0
    @State private var requestSignIn = false
    @Environment(\.colorScheme) private var scheme
    
    var body: some View {
        NavigationStack {
            VStack {
                //header
                
                
                // picker
                tabbarTypePicker
                
                //main view
                ScrollView {
                    TabView(selection: $selectedType) {
                        
                    }
                    .tabViewStyle(.page)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var tabbarTypePicker: some View {
        HStack(spacing: 0) {
            ForEach(FavoriteType.allCases) { type in
                Button {
                    tabTapped(type)
                } label: {
                    HStack(spacing: 10) {
                        Text(type.rawValue)
                            .fontWeight(.semibold)
                            .font(.callout)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .contentShape(Capsule())
                }
                .buttonStyle(.plain)
            }
        }
        .tabMask(tabProgress)
        .background {
            GeometryReader { proxy in
                let size = proxy.size
                let capsuleWidth = size.width / CGFloat(FavoriteType.allCases.count)
                Capsule()
                    .fill(scheme == .dark ? .green : .white)
                    .padding(4)
                    .frame(width: capsuleWidth)
                    .offset(x: tabProgress * (size.width - capsuleWidth))
            }
        }
        .background(Color.gray.opacity(0.2))
        .clipShape(Capsule())
        .padding(.horizontal)
    }
    
    private func tabTapped(_ type: FavoriteType) {
        withAnimation(.spring()) {
            selectedType = type
            switch type {
            case .onReading:
                tabProgress = 0
            case .readingList:
                tabProgress = 0.5
            case .archived:
                tabProgress = 1
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}

// MARK: - Tab mask for text in capsule

extension View {
    @ViewBuilder
    func tabMask(_ tabProgress: CGFloat) -> some View {
        ZStack {
            self
                .foregroundStyle(.secondary)
            
            self
                .symbolVariant(.fill)
                .mask {
                    GeometryReader { proxy in
                        let size = proxy.size
                        let capsuleWidth = size.width / CGFloat(FavoriteType.allCases.count)
                        Capsule()
                            .frame(width: capsuleWidth)
                            .offset(x: tabProgress * (size.width - capsuleWidth))
                    }
                }
        }
    }
}
