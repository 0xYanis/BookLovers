//
//  Color+Extension.swift
//  BookLovers
//
//  Created by Yanis on 21.03.2024.
//

import SwiftUI

extension Color {
    static var systemBackground: Color {
        #if os(iOS)
        Color(.systemBackground)
        #else
        Color(nsColor: .controlBackgroundColor)
        #endif
    }
}
