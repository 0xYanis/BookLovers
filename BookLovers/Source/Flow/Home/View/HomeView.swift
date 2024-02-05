//
//  HomeView.swift
//  BookLovers
//
//  Created by Yanis on 24.01.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var flow: FlowManager
    
    var body: some View {
        List(viewModel.books) { book in
            Text(book.volumeInfo.title)
        }
        .onAppear(perform: viewModel.showList)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
