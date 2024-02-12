//
//  WelcomeView.swift
//  BookLovers
//
//  Created by Yanis on 09.02.2024.
//

import SwiftUI

struct WelcomeView: View {
    let title: String
    let items: [WelcomeFeature]
    let subbuttonTitle: String
    let bigButtonTitle: String
    
    let subbuttonAction: () -> Void
    let bigButtonAction: () -> Void
    
    var body: some View {
        VStack(spacing: 32) {
            Text(title)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .fontWeight(.bold)
                .fontDesign(.rounded)
                .padding(.vertical)
            Spacer()
            VStack(alignment: .leading, spacing: 32) {
                ForEach(items) { item in
                    WelcomeItemView(item: item)
                }
            }
            .padding(.horizontal)
            .padding(.horizontal)
            Spacer()
            VStack(spacing: 30) {
                if subbuttonTitle.isEmpty == false {
                    Button(action: subbuttonAction) {
                        Text(subbuttonTitle)
                            .font(.callout)
                    }
                }
                
                BigButton(
                    title: bigButtonTitle,
                    action: bigButtonAction
                )
            }
            Spacer()
        }
        .padding()
    }
}

fileprivate struct WelcomeItemView: View {
    let item: WelcomeFeature
    
    var body: some View {
        HStack {
            Image(systemName: item.image)
                .imageScale(.medium)
                .font(.title)
                .foregroundStyle(item.color)
                .frame(width: 80)
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.callout)
                Text(item.subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(
            title: WelcomeMessage.first.rawValue,
            items: WelcomeFeature.firstScreen,
            subbuttonTitle: "",
            bigButtonTitle: "Continue",
            subbuttonAction: {},
            bigButtonAction: {})
    }
}
