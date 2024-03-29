//
//  BubbleShape.swift
//  BookLovers
//
//  Created by Yanis on 16.02.2024.
//

import SwiftUI

#if os(macOS)
#else
public struct BubbleShape: Shape {
    private var myMessage: Bool
    
    public init(myMessage: Bool) {
        self.myMessage = myMessage
    }
    
    public func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        
        let path = UIBezierPath()
        if !myMessage {
            path.move(to: CGPoint(x: 20, y: height))
            path.addLine(to: CGPoint(x: width - 15, y: height))
            path.addCurve(to: CGPoint(x: width, y: height - 15), controlPoint1: CGPoint(x: width - 8, y: height), controlPoint2: CGPoint(x: width, y: height - 8))
            path.addLine(to: CGPoint(x: width, y: 15))
            path.addCurve(to: CGPoint(x: width - 15, y: 0), controlPoint1: CGPoint(x: width, y: 8), controlPoint2: CGPoint(x: width - 8, y: 0))
            path.addLine(to: CGPoint(x: 20, y: 0))
            path.addCurve(to: CGPoint(x: 5, y: 15), controlPoint1: CGPoint(x: 12, y: 0), controlPoint2: CGPoint(x: 5, y: 8))
            path.addLine(to: CGPoint(x: 5, y: height - 10))
            path.addCurve(to: CGPoint(x: 0, y: height), controlPoint1: CGPoint(x: 5, y: height - 1), controlPoint2: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: -1, y: height))
            path.addCurve(to: CGPoint(x: 12, y: height - 4), controlPoint1: CGPoint(x: 4, y: height + 1), controlPoint2: CGPoint(x: 8, y: height - 1))
            path.addCurve(to: CGPoint(x: 20, y: height), controlPoint1: CGPoint(x: 15, y: height), controlPoint2: CGPoint(x: 20, y: height))
        } else {
            path.move(to: CGPoint(x: width - 20, y: height))
            path.addLine(to: CGPoint(x: 15, y: height))
            path.addCurve(to: CGPoint(x: 0, y: height - 15), controlPoint1: CGPoint(x: 8, y: height), controlPoint2: CGPoint(x: 0, y: height - 8))
            path.addLine(to: CGPoint(x: 0, y: 15))
            path.addCurve(to: CGPoint(x: 15, y: 0), controlPoint1: CGPoint(x: 0, y: 8), controlPoint2: CGPoint(x: 8, y: 0))
            path.addLine(to: CGPoint(x: width - 20, y: 0))
            path.addCurve(to: CGPoint(x: width - 5, y: 15), controlPoint1: CGPoint(x: width - 12, y: 0), controlPoint2: CGPoint(x: width - 5, y: 8))
            path.addLine(to: CGPoint(x: width - 5, y: height - 12))
            path.addCurve(to: CGPoint(x: width, y: height), controlPoint1: CGPoint(x: width - 5, y: height - 1), controlPoint2: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: width + 1, y: height))
            path.addCurve(to: CGPoint(x: width - 12, y: height - 4), controlPoint1: CGPoint(x: width - 4, y: height + 1), controlPoint2: CGPoint(x: width - 8, y: height - 1))
            path.addCurve(to: CGPoint(x: width - 20, y: height), controlPoint1: CGPoint(x: width - 15, y: height), controlPoint2: CGPoint(x: width - 20, y: height))
        }
        return Path(path.cgPath)
    }
}
#endif
