//
//  DefaultImageView.swift
//  BookLovers
//
//  Created by Yanis on 22.03.2024.
//

import SwiftUI

public struct DefaultImageView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    public init() {}
    
    public var body: some View {
        GeometryReader { proxy in
            Rectangle()
                .fill(.green.opacity(0.8))
                .overlay {
                    Color(colorScheme == .light ? .white : .black)
                        .frame(width: 50, height: 50)
                        .mask {
                            Image("logo-small")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                }
                .frame(maxHeight: 220)
        }
    }
}
