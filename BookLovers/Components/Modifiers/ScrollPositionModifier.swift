//
//  ScrollPositionModifier.swift
//  BookLovers
//
//  Created by Yanis on 13.02.2024.
//

import SwiftUI

struct ScrollPositionModifier: ViewModifier {
    @Binding var offset: CGFloat
    let coordinateSpace: String
    
    func body(content: Content) -> some View {
        content
            .background(GeometryReader { proxy -> Color in
                offset = -proxy.frame(in: .named(coordinateSpace)).origin.y
                print(offset)
                return Color.clear
            })
    }
}
