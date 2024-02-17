//
//  ProfileView.swift
//  BookLovers
//
//  Created by Yanis on 17.02.2024.
//

import SwiftUI
import ScalingHeaderScrollView

enum SnapPosition {
    case hide
    case normal
    case extended
}

struct ProfileView: View {
    @State private var snapPositions: [CGFloat] = [0, 1]
    @State private var currentSnapPos: SnapPosition = .normal
    @State private var scrollOffset: CGFloat = 0
    @State private var progress: CGFloat = 0
    
    @Namespace private var headerSnap
    
    private let minHeight: CGFloat = 100
    private let maxHeight: CGFloat = 350
    
    var body: some View {
        scalingHeaderScrollView
            .onChange(of: progress) { newValue in
                withAnimation(.spring(response: 0.2)) {
                    if newValue >= 0.75 {
                        currentSnapPos = .hide
                    } else if newValue <= 0.75 {
                        currentSnapPos = .normal
                    }
                }
            }
            .onChange(of: scrollOffset) { newValue in
                withAnimation(.spring(response: 0.2)) {
                    if scrollOffset < -1 && scrollOffset < -100 {
                        currentSnapPos = .extended
                    }
                }
            }
    }
    
    private var scalingHeaderScrollView: some View {
        ScalingHeaderScrollView {
            ProfileHeader(currentSnapPos: $currentSnapPos, headerSnap: headerSnap)
        } content: {
            
        }
        .scrollOffset($scrollOffset)
        .collapseProgress($progress)
        .headerSnappingPositions(snapPositions: snapPositions)
        .allowsHeaderCollapse()
        .height(min: minHeight, max: maxHeight)
        .hideScrollIndicators()
        .ignoresSafeArea()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
