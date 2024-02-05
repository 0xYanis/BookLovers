//
//  SideMenuHeader.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

struct SideMenuHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .imageScale(.large)
                .foregroundColor(.white)
                .frame(width: 48, height: 48)
                .background(.blue)
                .clipShape(Circle())
                .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Yanis Rybkin")
                    .font(.subheadline)
                
                Text("test@gmail.com")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
    }
}
