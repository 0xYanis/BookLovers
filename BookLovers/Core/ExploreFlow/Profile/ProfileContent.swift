//
//  ProfileContent.swift
//  BookLovers
//
//  Created by Yanis on 17.02.2024.
//

import SwiftUI
import Components

struct ProfileContent: View {
    @State private var showSignIn = false
    @EnvironmentObject private var userStore: UserStore
    
    var body: some View {
        Form {
            avatarView()

            Section {
                if userStore.user.isAuthenticated {
                    Label {
                        Text("Email:")
                        Text(userStore.user.email)
                            .foregroundStyle(.gray)
                    } icon: {
                        Image(systemName: "mail")
                    }
                }
                userData()
            }
            signInButton()
        }
        .sheet(isPresented: $showSignIn, content: LoginView.init)
    }
    
    private func avatarView() -> some View {
        Section {
            Label {
                PhotosPickerView("Change photo").foregroundStyle(.blue)
            } icon: {
                Image(systemName: "photo")
            }
        } header: {
            VStack {
                ProfileAvatar()
                Text(userStore.user.username)
            }
            .frame(maxWidth: .infinity)
        }
        .headerProminence(.increased)
    }
    
    @ViewBuilder
    private func userData() -> some View {
        Label {
            Text("Status:")
            Text(userStore.user.status)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
        } icon: {
            Image(systemName: "quote.opening")
        }

        Picker("Favorite genre:", selection: $userStore.user.favoriteGenre) {
            ForEach(LiteraryGenre.allCases) { genre in
                Text(genre.title).tag(genre)
            }
        }
        .pickerStyle(.navigationLink)
    }
    
    @ViewBuilder
    private func signInButton() -> some View {
        if !userStore.user.isAuthenticated {
            Section {
                Button("Sign in", action: { showSignIn.toggle() })
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundStyle(.white)
            }
            .listRowBackground(Color.green)
        }
    }
}

struct ProfileContent_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileContent()
                .environmentObject(UserStore())
        }
    }
}
