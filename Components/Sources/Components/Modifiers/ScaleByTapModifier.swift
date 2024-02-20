//
//  ScaleByTapModifier.swift
//  BookLovers
//
//  Created by Yanis on 12.02.2024.
//

import SwiftUI

public struct ScaleByTapModifier: ViewModifier {
    let scale: CGFloat
    @State private var state = false
    
    public func body(content: Content) -> some View {
        content
            .scaleEffect(state ? scale : 1.0)
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .global)
                    .onChanged { _ in
                        withAnimation(.easeInOut(duration: 0.09)) {
                            state = true
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            state = false
                        }
                    }
            )
    }
}
