//
//  View+AlertExtensions.swift
//  BookLovers
//
//  Created by Yanis on 29.02.2024.
//

import SwiftUI

extension View {
    func alertToast(isPresented: SwiftUI.Binding<Bool>) -> some View {
        ZStack {
            self
//            AlertView(isPresented: isPresented)
                .animation(.easeIn(duration: 0.2), value: isPresented.wrappedValue)
        }
    }
}
