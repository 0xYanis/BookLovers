//
//  HistorySearch.swift
//  BookLovers
//
//  Created by Yanis on 24.03.2024.
//

import SwiftUI

struct HistorySearch: View {
    @Binding var history: [String]
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
                            Button {
                                deleteQuery(query)
                            } label: {
                                Image(systemName: "xmark")
                                    .imageScale(.small)
                            }
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
    
    private func deleteQuery(_ query: String) {
        guard let index = history.firstIndex(of: query)
        else { return }
        history.remove(at: index)
    }
}
