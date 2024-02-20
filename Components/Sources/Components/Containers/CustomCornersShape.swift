//
//  CustomCornersShape.swift
//  BookLovers
//
//  Created by Yanis on 06.02.2024.
//

import SwiftUI

public struct CustomCornersShape: Shape {
    private var corners: UIRectCorner
    private var radius: CGFloat
    
    public init(corners: UIRectCorner, radius: CGFloat) {
        self.corners = corners
        self.radius = radius
    }
    
    public func path(in rect: CGRect) -> Path {
        let size = CGSize(width: radius, height: radius)
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: size)
        return Path(path.cgPath)
    }
}
