//
//  CustomCornersShape.swift
//  BookLovers
//
//  Created by Yanis on 06.02.2024.
//

import SwiftUI

struct CustomCornersShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let size = CGSize(width: radius, height: radius)
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: size)
        return Path(path.cgPath)
    }
}
