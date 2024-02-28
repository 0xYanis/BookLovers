//
//  AlertView.swift
//  BookLovers
//
//  Created by Yanis on 28.02.2024.
//

import SwiftUI

struct AlertTestView: View {
    @State var show = false
    
    var body: some View {
        Button("show") {
            show.toggle()
        }
        .alertToast(isPresented: $show)
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertTestView()
    }
}
