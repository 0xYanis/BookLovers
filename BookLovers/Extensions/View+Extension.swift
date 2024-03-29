//
//  View+Extension.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI
import Components

// MARK: - Swipes

extension View {
    func onSwipe(
        up: @escaping (() -> Void) = {},
        down: @escaping (() -> Void) = {},
        left: @escaping (() -> Void) = {},
        right: @escaping (() -> Void) = {}
    ) -> some View {
        return self.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onEnded({ value in
                if value.translation.width < 0 { left() }
                if value.translation.width > 0 { right() }
                if value.translation.height < 0 { up() }
                if value.translation.height > 0 { down() }
            }))
    }
}

// MARK: - Tap actions

extension View {
    func scaleByTap(scale: CGFloat = 0.95) -> some View {
        modifier(ScaleByTapModifier(scale: scale))
    }
}

// MARK: - Screen size

extension View {
    var screen: CGRect {
#if os(macOS)
        NSScreen.main?.visibleFrame ?? .null
#else
        UIScreen.current?.bounds ?? .null
#endif
    }
    
    func scrollPosition(
        offset: Binding<CGFloat>,
        in coordinateSpace: String
    ) -> some View {
        modifier(ScrollPositionModifier(
            offset: offset,
            coordinateSpace: coordinateSpace)
        )
    }
    
    func saveSize(in size: Binding<CGSize>) -> some View {
        modifier(SizeCalculator(size: size))
    }
}
