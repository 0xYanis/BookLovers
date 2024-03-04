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
    @Namespace private var animation
    @FocusState private var isFocused: Bool
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    var body: some View {
        VStack(spacing: 0) {
            searchbar
                .padding(.top, safeAreaInsets.top)
                .padding(.vertical, 10)
                .matchedGeometryEffect(id: "searchfav", in: animation)
            tabbarTypePicker.padding(.top, 10)
            Divider()
        }
        .background(Material.ultraThinMaterial)
    }
    
    private var searchbar: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 5) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
                TextField("Search favorites", text: $searchText)
                    .focused($isFocused)
                if searchText.isEmpty == false {
                    Button {
                        searchText.removeAll()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.gray)
                }
            }
            .padding(.horizontal, 5)
        }
        .padding(10)
        .background(Color(.systemBackground))
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
                .background {
                    ZStack {
                        if selectedType == type {
                            VStack(spacing: 0) {
                                Spacer()
                                Capsule()
                                    .fill(.green)
                                    .frame(height: 4)
                                    .matchedGeometryEffect(id: "favcapsule", in: animation)
                            }
                        }
                    }
                }
                .tag(type)
            }
        }
        .animation(.spring(), value: selectedType)
        .padding(.horizontal)
    }
    
    private func tabTapped(_ type: FavoriteType) {
        withAnimation(.spring()) {
            selectedType = type
        }
    }
}

struct FavoritesHeader_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
