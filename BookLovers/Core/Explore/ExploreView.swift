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
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                    .buttonStyle(.plain)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image("avatar")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30)
                            .clipShape(Circle())
                    }
                }
            }
        }
    }
}

struct ExploreHeader: View {
    @State private var searchText = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Hello, Yanis")
                .font(.subheadline)
            
            Text("What are you looking for \ntoday?")
                .font(.title2)
                .fontWeight(.semibold)
            
            HStack(spacing: 0) {
                if !isFocused {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                        .foregroundStyle(.secondary)
                }
                TextField("Search books", text: $searchText)
                    .focused($isFocused)
                    .padding(.horizontal, 3)
                    .padding(.vertical, 7)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.0)
                    .foregroundStyle(.secondary)
            )
            
        }
        .onTapGesture {
            isFocused = false
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
