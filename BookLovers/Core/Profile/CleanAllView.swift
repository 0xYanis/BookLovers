//
//  CleanAllView.swift
//  BookLovers
//
//  Created by Yanis on 19.02.2024.
//

import SwiftUI
import Components

struct CleanAllView: View {
    @EnvironmentObject private var userStore: UserStore
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            Text("Are you sure?")
                .fontWeight(.semibold)
            
            Text("All user data will be cleaned")
                .multilineTextAlignment(.center)
                .font(.title)
                .fontWeight(.semibold)
                .padding(32)
            Spacer()
            BigButton(title: "Confirm", action: userStore.clearUserData)
                .padding()
        }
        .padding(.horizontal)
        .overlay(alignment: .topTrailing) {
            Button("Cancel", action: dismiss.callAsFunction)
                .tint(.red)
                .padding()
        }
    }
    
    private func removeAction() {
        
    }
}

struct CleanAllView_Previews: PreviewProvider {
    static var previews: some View {
        CleanAllView()
            .environmentObject(UserStore())
    }
}
