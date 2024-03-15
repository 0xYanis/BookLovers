//
//  AboutUsView.swift
//  BookLovers
//
//  Created by Yanis on 28.02.2024.
//

import SwiftUI
import Components

struct AboutUsView: View {
    var body: some View {
        List {
            allParagraphs
            Section {
                footerTitleLabel
                linkToGithub
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle("About Us")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var allParagraphs: some View {
        ForEach(AboutUs.allCases) { part in
            Section {
                Text(part.title).font(.headline)
                Text(part.text).font(.callout)
            }
        }
    }
    
    private var footerTitleLabel: some View {
        Text("The Bookly Team")
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private var linkToGithub: some View {
        if let destination = AboutUs.link {
            Link(destination: destination) {
                Label("Show website", systemImage: "rectangle.portrait.and.arrow.right")
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding()
        }
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AboutUsView()
        }
    }
}

fileprivate enum AboutUs: String, CaseIterable, Identifiable {
    case welcome
    case mission
    case features
    case vision
    
    static var link: URL? {
        URL(string: "https://github.com/0xYanis/BookLovers")
    }
    
    var id: String { rawValue }
    var title: String { rawValue.capitalized }
    var text: String {
        switch self {
        case .welcome:
            return
"""
Welcome to Bookly, your ultimate companion for all things literary. At Bookly, we are passionate about enhancing the reading experience and bringing book lovers together. Our app is designed to make discovering, organizing, and enjoying your favorite books easier and more enjoyable than ever before.
"""
        case .mission:
            return
"""
At Bookly, our mission is simple - to inspire and empower readers to explore the world of literature in a convenient and engaging way. We aim to foster a vibrant community of book enthusiasts and provide a platform where they can connect, share their love for reading, and discover new literary treasures.
"""
        case .features:
            return
"""
Bookly offers a range of features to enrich your reading journey:

- Personalized Recommendations: Our algorithm learns your reading preferences to suggest books tailored to your tastes.
- Digital Library: Access your entire library in one place, organize your collection, and keep track of books you’ve read, are currently reading, or plan to read in the future.
- Community Engagement: Interact with fellow readers, join book clubs, and participate in discussions about your favorite books and authors.
- Reading Challenges: Set and track reading goals, and challenge yourself to explore new genres and authors.
- Book Reviews: Share your thoughts on books you've read and read reviews from other members of the Bookly community.
"""
        case .vision:
            return
"""
We envision Bookly as the go-to app for book lovers worldwide. Whether you are a casual reader, a dedicated bookworm, or a literary enthusiast, Bookly aims to be your indispensable companion, enhancing every aspect of your reading life. We are committed to continuous improvement and innovation to provide the best possible experience for our users.

Join us on this literary adventure and let Bookly become your trusted companion on your reading journey.

Thank you for choosing Bookly. Happy reading!
"""
        }
    }
}
