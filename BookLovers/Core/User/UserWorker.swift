//
//  UserWorker.swift
//  BookLovers
//
//  Created by Yanis on 16.03.2024.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseStorage

protocol UserWorkerProtocol: AnyObject {
    var currentUser: User { get }
    
    func getAvatarUrl() async -> URL?
    func changeAvatar(_ data: Data) async -> URL?
    func changeName(_ name: String)
    func logout()
    func delete()
}

class UserWorker: UserWorkerProtocol {
    private let auth = Auth.auth()
    private let storage = Storage.storage()
    
    lazy var currentUser: User = {
        guard let user = auth.currentUser else { return .anonymous }
        let displayName = (user.displayName != nil) ? user.displayName : user.email?.emailToName()
        return User(
            avatar: user.photoURL,
            email: user.email,
            username: displayName,
            isAuthenticated: !user.isAnonymous
        )
    }()
    
    func getAvatarUrl() async -> URL? {
        guard let userId = auth.currentUser?.uid else { return nil }
        let url = try? await path(userId: userId).downloadURL()
        return url
    }
    
    func changeAvatar(_ data: Data) async -> URL? {
        guard let userId = auth.currentUser?.uid else { return nil }
        let meta = StorageMetadata()
        meta.contentType = "image.jpeg"
        let _ = try? await path(userId: userId).putDataAsync(data, metadata: meta)
        let url = await getAvatarUrl()
        setAuthImageUrl(url); return url
    }
    
    private func setAuthImageUrl(_ url: URL?) {
        guard let user = auth.currentUser else { return }
        let request = user.createProfileChangeRequest()
        request.photoURL = url
        request.commitChanges()
    }
    
    func changeName(_ name: String) {
        guard let user = auth.currentUser else { return }
        let request = user.createProfileChangeRequest()
        request.displayName = name
        request.commitChanges()
    }
    
    func logout() {
        try? auth.signOut()
    }
    
    func delete() {
        auth.currentUser?.delete()
    }
    
    private func path(userId: String) -> StorageReference {
        return storage.reference().child("avatars").child(userId)
    }
}
