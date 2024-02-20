//
//  ScrollPositionModifier.swift
//  BookLovers
//
//  Created by Yanis on 13.02.2024.
//

import SwiftUI

public struct ScrollPositionModifier: ViewModifier {
    @Binding private var offset: CGFloat
    private let coordinateSpace: String
    
    public init(offset: Binding<CGFloat>, coordinateSpace: String) {
        self._offset = offset
        self.coordinateSpace = coordinateSpace
    }
    
    public func body(content: Content) -> some View {
        content
            .background(GeometryReader { proxy -> Color in
                offset = -proxy.frame(in: .named(coordinateSpace)).origin.y
                print(offset)
                return Color.clear
            })
    }
}
