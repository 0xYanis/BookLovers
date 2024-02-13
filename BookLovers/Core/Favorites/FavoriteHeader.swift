//
//  FavoriteHeader.swift
//  BookLovers
//
//  Created by Yanis on 13.02.2024.
//

import SwiftUI

struct FavoriteHeader: View {
    @Binding var searchText: String
    @Binding var selectedType: FavoriteType
    
    @State private var tabProgress: CGFloat = 0
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            //header
            searchbar
                .padding(.vertical, 10)
            // picker
            tabbarTypePicker
                .padding(.top, 10)
            
            Divider()
        }
    }
    private var searchbar: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 5) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
                TextField("Search favorites", text: $searchText)
                    .focused($isFocused)
                Button {
                    searchText.removeAll()
                } label: {
                    Image(systemName: searchText.isEmpty ? "" : "xmark")
                }
                .buttonStyle(.plain)
                .foregroundStyle(.gray)
            }
            .padding(.horizontal, 5)
        }
        .padding(10)
        .background(Color(.tertiarySystemGroupedBackground))
        .clipShape(Capsule())
        .padding(.horizontal)
    }
    
    private var tabbarTypePicker: some View {
        HStack(spacing: 15) {
            ForEach(FavoriteType.allCases) { type in
                Button {
                    tabTapped(type)
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: type.image)
                            .imageScale(.small)
                        Text(type.rawValue)
                    }
                    .font(.callout)
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
                VStack(spacing: 0) {
                    Spacer()
                    Capsule()
                        .fill(.green)
                        .padding(4)
                        .frame(width: capsuleWidth)
                        .frame(height: 12)
                        .offset(x: tabProgress * (size.width - capsuleWidth))
                        .offset(y: 5)
                }
            }
        }
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

struct FavoritesHeader_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
