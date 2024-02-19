//
//  ProfileEditorView.swift
//  BookLovers
//
//  Created by Yanis on 19.02.2024.
//

import SwiftUI
import PhotosUI

struct ProfileEditorView: View {
    @State private var selection: PhotosPickerItem?
    @State private var showSignIn = false
    @EnvironmentObject private var userStore: UserStore
    
    var body: some View {
        VStack(spacing: 0) {
            List {
                Section(
                    content: {
                        HStack {
                            Text("Name")
                            Divider()
                            TextField("\(userStore.username)", text: $userStore.username)
                        }
                    },
                    header: imageHeader,
                    footer: nameFooter
                )
                .headerProminence(.increased)
                
                Section {
                    TextField("Status", text: $userStore.userStatus)
                } footer: {
                    Text("Tell the world about yourself in a nutshell.")
                }
                
                Section {
                    if userStore.isAuthenticated {
                        Label("Change email address", systemImage: "mail")
                    } else {
                        Button("Sign in", action: showSignInAction)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .tint(.white)
                    }
                } header: {
                    Text("Account")
                }
                .listRowBackground(userStore.isAuthenticated ? .none : Color.green)
                
                Section {
                    Button("Remove account", action: deleteAccountAciton)
                        .disabled( !userStore.isAuthenticated )
                        .frame(maxWidth: .infinity, alignment: .center)
                } footer: {
                    Text("You can easily delete your account and all data associated with it.")
                }
                .tint(.white)
                .listRowBackground(Color.red.opacity(userStore.isAuthenticated ? 1.0 : 0.5))
            }
        }
        .sheet(isPresented: $showSignIn) {
            LoginView(isRegistrationView: false)
        }
        .onChange(of: selection) { selected in
            Task {
                if let data = try? await selected?.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    userStore.setImage(Image(uiImage: image))
                }
            }
        }
    }
    
    private func imageHeader() -> some View {
        ZStack(alignment: .center) {
            Color.clear
            VStack(spacing: 25) {
                userStore.image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 130, height: 130)
                    .clipShape(Circle())
                    .clipped()
                
                PhotosPicker("Change avatar", selection: $selection)
            }
            .padding(.vertical)
        }
        .listRowInsets(EdgeInsets())
    }
    
    private func nameFooter() -> some View {
        Text("Here you can enter your name and change your photo.")
    }
    
    private func showSignInAction() {
        showSignIn.toggle()
    }
    
    private func deleteAccountAciton() {
        
    }
}

struct ProfileEditorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditorView()
            .environmentObject(UserStore())
    }
}
