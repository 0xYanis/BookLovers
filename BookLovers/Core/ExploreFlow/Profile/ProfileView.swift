//
//  ProfileView.swift
//  BookLovers
//
//  Created by Yanis on 17.02.2024.
//

import SwiftUI

struct ProfileView: View {
    @Namespace private var headerSnap
    @Environment(\.editMode) private var editMode
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var userStore: UserStore
    
    var body: some View {
        ZStack {
            if editMode?.wrappedValue == .active {
                ProfileEditorView()
            } else {
                ProfileContent()
            }
        }
        .navigationTitle("Profile · \(userStore.user.username)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .toolbar(content: EditButton.init)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView()
                .environmentObject(UserStore())
        }
    }
}
