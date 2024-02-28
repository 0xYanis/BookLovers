//
//  View+AlertExtensions.swift
//  BookLovers
//
//  Created by Yanis on 29.02.2024.
//

import SwiftUI

extension View {
    func alertToast<Content>(
        isPresented: SwiftUI.Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content : View {
        ZStack {
            self
            
            AlertToastItem(
                isPresented: isPresented,
                shape: RoundedRectangle(cornerRadius: 12),
                background: Color(.secondarySystemBackground),
                content: content
            )
            .animation(.easeIn(duration: 0.2), value: isPresented.wrappedValue)
        }
    }
}
