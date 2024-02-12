//
//  View+Extension.swift
//  BookLovers
//
//  Created by Yanis on 05.02.2024.
//

import SwiftUI

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

// MARK: - Screen size
extension View {
    var screen: CGRect {
        UIScreen.current?.bounds ?? .null
    }
}
