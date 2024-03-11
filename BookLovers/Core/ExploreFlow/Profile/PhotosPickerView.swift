//
//  PhotosPickerView.swift
//  BookLovers
//
//  Created by Yanis on 20.02.2024.
//

import SwiftUI
import PhotosUI

struct PhotosPickerView: View {
    private let title: String
    
    @State private var selection: PhotosPickerItem?
    @EnvironmentObject private var userStore: UserStore
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        ZStack { PhotosPicker(title, selection: $selection) }
        .onChange(of: selection) { selected in
            Task { await changePhoto(selected) }
        }
    }
    
    private func changePhoto(_ selected: PhotosPickerItem?) async {
        if let _ = try? await selected?.loadTransferable(type: Data.self) {
            userStore.setImage(imageUrl: nil)
        }
    }
}

struct PhotosPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosPickerView("Change profile photo")
    }
}
