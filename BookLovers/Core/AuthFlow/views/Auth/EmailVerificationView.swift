//
//  EmailVerificationView.swift
//  BookLovers
//
//  Created by Yanis on 06.03.2024.
//

import SwiftUI
import Lottie

struct EmailVerificationView: View {
    var cancel: () -> ()
    var onReceive: () -> ()
    
    var body: some View {
        VStack(spacing: 6) {
            if let bundle = Bundle.main.path(forResource: "verification", ofType: "json") {
                LottieView {
                    await LottieAnimation.loadedFrom(url: URL(filePath: bundle))
                }
                .playing(loopMode: .loop)
            }
            Text("Verification")
                .font(.title.bold())
            Text("We have sent a verification email to your email address. \nPlease verify to continue.")
                .multilineTextAlignment(.center)
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.horizontal, 25)
        }
        .padding(.bottom)
        .overlay(alignment: .topTrailing) {
            Button("Cancel", action: cancel).padding()
        }
        .onReceive(Timer.publish(every: 2, on: .main, in: .default).autoconnect()) { _ in
            onReceive()
            print("RECIEVE")
        }
    }
}

struct EmailVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
