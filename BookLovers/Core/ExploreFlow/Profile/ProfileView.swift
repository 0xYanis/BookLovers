//
//  ProfileView.swift
//  BookLovers
//
//  Created by Yanis on 17.02.2024.
//

import SwiftUI

enum SnapPosition {
    case hide
    case normal
    case extended
}

struct ProfileView: View {
    @Namespace private var headerSnap
    @Environment(\.editMode) private var editMode
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var userStore: UserStore
    
    private let minHeight: CGFloat = 100
    private let maxHeight: CGFloat = 350
    
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
        .toolbar {
            EditButton()
        }
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
