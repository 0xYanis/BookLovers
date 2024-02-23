//
//  SizeCalculator.swift
//  
//
//  Created by Yanis on 23.02.2024.
//

import SwiftUI

public struct SizeCalculator: ViewModifier {
    @Binding private var size: CGSize
    
    public init(size: Binding<CGSize>) {
        self._size = size
    }
    
    public func body(content: Content) -> some View {
        content.background(
            GeometryReader { proxy in
                Color.clear.onAppear { size = proxy.size }
            }
        )
    }
}
