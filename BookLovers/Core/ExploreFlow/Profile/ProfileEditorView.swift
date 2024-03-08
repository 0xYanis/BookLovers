//
//  ProfileEditorView.swift
//  BookLovers
//
//  Created by Yanis on 19.02.2024.
//

import SwiftUI
import AlertKit

struct ProfileEditorView: View {
    @State private var showSignIn = false
    @State private var showCleanAll = false
    @State private var showDeleteAlert = false
    
    @EnvironmentObject private var userStore: UserStore
    var body: some View {
        VStack {
            Form {
                Section(
                    content: {
                        HStack {
                            Text("Name")
                            Divider()
                            TextField("\(userStore.user.username)", text: $userStore.user.username)
                        }
                    },
                    header: imageHeader,
                    footer: nameFooter
                )
                .headerProminence(.increased)
                
                Section {
                    TextField("Status", text: $userStore.user.status)
//                    Picker("Favorite genre:", selection: $userStore.user.favoriteGenre) {
//                        ForEach(LiteraryGenre.allCases) { genre in
//                            Text(genre.title).tag(genre)
//                        }
//                    }
//                    .pickerStyle(.menu)
                } footer: {
                    Text("Tell the world about yourself in a nutshell.")
                }
                
                Section {
                    if userStore.user.isAuthenticated {
                        Label("Change email address", systemImage: "mail")
                    } else {
                        Button("Sign in", action: { showSignIn.toggle() })
                            .frame(maxWidth: .infinity, alignment: .center)
                            .tint(.white)
                    }
                } header: {
                    Text("Account")
                }
                .listRowBackground(userStore.user.isAuthenticated ? .none : Color.green)
                
                Section {
                    Button(action: { showCleanAll.toggle() }) {
                        Label("Clean all user data", systemImage: "trash")
                            .foregroundStyle(.red)
                    }
                }
                
                if userStore.user.isAuthenticated {
                    Section {
                        Button("Remove account", action: { showDeleteAlert.toggle() })
                            .frame(maxWidth: .infinity, alignment: .center)
                    } footer: {
                        Text("You can easily delete your account and all data associated with it.")
                    }
                    .tint(.white)
                    .listRowBackground(Color.red.opacity(userStore.user.isAuthenticated ? 1.0 : 0.5))
                }
            }
        }
        .alertBar(
            isPresented: $showCleanAll,
            timeInterval: 10,
            shape: RoundedRectangle(cornerRadius: 15),
            background: Material.ultraThinMaterial) {
                HStack {
                    Button("Clean", action: { userStore.clearUserData() })
                        .foregroundStyle(.white)
                        .padding(12)
                        .background(.red)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    Text("All data will be cleaned")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                    Button("Cancel", action: { showCleanAll = false })
                        .foregroundStyle(.white)
                        .padding(12)
                        .background(.secondary)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .frame(maxWidth: .infinity)
            }
            .shadow(color: .black.opacity(0.12), radius: 20)
        .sheet(isPresented: $showSignIn) {
            LoginView()
                .presentationDetents([.medium, .large])
        }
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Account deleting"),
                message: Text("All personal data will be deleted"),
                primaryButton: .destructive(Text("Delete"), action: userStore.deleteAccount),
                secondaryButton: .cancel())
        }
        .onDisappear {
            userStore.setName(userStore.user.username)
        }
    }
    
    private func imageHeader() -> some View {
        ZStack(alignment: .center) {
            Color.clear
            VStack(spacing: 25) {
                Avatar(url: userStore.user.avatar)
                    .scaledToFill()
                    .frame(width: 130, height: 130)
                    .clipShape(Circle())
                    .clipped()
                
                PhotosPickerView("Change photo")
            }
            .padding(.vertical)
        }
        .listRowInsets(EdgeInsets())
    }
    
    private func nameFooter() -> some View {
        Text("Here you can enter your name and change your photo.")
    }
    
    private func deleteAccountAciton() {
        userStore.deleteAccount()
    }
}

struct ProfileEditorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditorView().environmentObject(UserStore())
    }
}
