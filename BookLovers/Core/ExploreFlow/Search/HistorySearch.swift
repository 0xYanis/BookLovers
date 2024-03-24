//
//  HistorySearch.swift
//  BookLovers
//
//  Created by Yanis on 24.03.2024.
//

import SwiftUI

struct HistorySearch: View {
    var history: [String]
    var perform: (String) -> ()
    
    var body: some View {
        if !history.isEmpty {
            VStack(alignment: .leading, spacing: 15) {
                ForEach(history, id: \.self) { query in
                    Button(action: { perform(query) }) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .padding(.horizontal)
                                .foregroundStyle(.gray)
                            Text(query)
                            Spacer()
                            Image(systemName: "clock.arrow.circlepath")
                        }
                        .font(.callout)
                    }
                    .buttonStyle(.plain)
                    Divider()
                }
            }
            .padding()
        }
    }
}
