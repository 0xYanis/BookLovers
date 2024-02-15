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
    @Binding var offset: CGFloat
    
    @Namespace private var animation
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            //header
            if isScrolling == false {
                searchbar
                    .opacity(isScrolling ? 0 : 1)
                    .padding(.vertical, 10)
                    .matchedGeometryEffect(id: "searchfav", in: animation)
            }
            // picker
            tabbarTypePicker
                .padding(.top, 10)
            
            Divider()
        }
        .animation(.spring(response: 0.12), value: isScrolling)
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
                .background {
                    ZStack {
                        if selectedType == type {
                            if isScrolling == false {
                                Capsule()
                                    .fill(.green)
                                    .padding(4)
                                    .matchedGeometryEffect(id: "favcapsule", in: animation)
                            } else {
                                Capsule()
                                    .fill(.green)
                                    .padding(4)
                                    .frame(height: 12)
                                    .matchedGeometryEffect(id: "favcapsule", in: animation)
                            }
                        }
                    }
                }
            }
        }
        .background {
            if isScrolling == false {
                Capsule()
                    .fill(Color(.systemGroupedBackground))
            }
        }
        .padding(.bottom, isScrolling ? 0 : 15)
        .padding(.horizontal)
    }
    
    private var isScrolling: Bool {
        abs(offset < 0 ? 0 : offset) > 150
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
