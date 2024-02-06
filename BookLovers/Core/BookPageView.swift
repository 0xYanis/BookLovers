//
//  BookPageView.swift
//  BookLovers
//
//  Created by Yanis on 06.02.2024.
//

import SwiftUI

struct BookPageView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 32) {
                    Image("book1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 135)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.top, 30)
                    
                    Text("The Master and Margarita")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("by Mikhail Bulgakov")
                        .font(.subheadline)
                    
                    HStack {
                        ForEach(0..<4, id: \.self) { item in
                            VStack(spacing: 10) {
                                Text("Rating")
                                    .font(.callout)
                                
                                Text("4.37")
                                    .font(.headline)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    Spacer()
                }
                
                VStack {
                    NewParagraphView(title: "Plot summary") {
                        VStack {
                            Text(summary)
                                .font(.subheadline)
                                .padding(.vertical, 5)
                                .padding(.horizontal)
                        }
                    } topItem: {}
                    
                    NewParagraphView(title: "Reception") {
                        VStack {
                            Text(reception)
                                .font(.subheadline)
                                .padding(.vertical, 5)
                                .padding(.horizontal)
                        }
                    } topItem: {}
                    
                    NewParagraphView(title: "Awards") {
                        VStack {
                            Text(awards)
                                .font(.subheadline)
                                .padding(.vertical, 5)
                                .padding(.horizontal)
                        }
                    } topItem: {}
                }
                .padding(.vertical)
            }
            
            Button {
                isShowing.toggle()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundStyle(.secondary)
            }
            .buttonStyle(.plain)
            .padding(.horizontal)
        }
    }
}

struct BookPageView_Previews: PreviewProvider {
    static var previews: some View {
        BookPageView(isShowing: .constant(true))
    }
}

var summary = "The novel is set in Moscow and tells the story of the devil Woland and his entourage, who arrive in the city and cause chaos. The story is intertwined with the story of the Master, a writer who has written a novel about Pontius Pilate, and Margarita, a woman who makes a deal with the devil to find her beloved Master."

var themes = "Satire, religion, love, art, power, and the absurdity of life"

var reception = "The novel has been praised for its rich and complex characters, its biting social commentary, and its unique blend of genres. It has been translated into many languages and is considered a classic of 20th-century literature."

var awards = "The novel has not won any major awards, but it has been recognized as a significant work of literature."
