//
//  RectImage.swift
//  BookLovers
//
//  Created by Yanis on 19.02.2024.
//

import SwiftUI

public struct RectImage: View {
    let systemImage: String
    let color: Color
    let screen: CGSize
    
    public var body: some View {
        Image(systemName: systemImage)
            .foregroundStyle(.white)
            .padding(5)
            .frame(width: screen.width*0.075, height: screen.width*0.075)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 7))
    }
}
