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
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var userStore: UserStore
    
    private let minHeight: CGFloat = 100
    private let maxHeight: CGFloat = 350
    
    var body: some View {
        scalingHeaderScrollView
            .overlay(alignment: .top) {
                HStack {
                    leadingButton
                    Spacer()
                    trailingButton
                }
                .padding(.horizontal)
            }
            .toolbar(.hidden, for: .navigationBar)
            .toolbar(.hidden, for: .tabBar)
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
    
    @ViewBuilder
    private var leadingButton: some View {
        if currentSnapPos == .extended {
            Button(action: {
                dismiss.callAsFunction()
            }, label: {
                Image(systemName: "chevron.left")
            })
            .matchedGeometryEffect(id: "leadingButt", in: headerSnap)
            .padding(5)
            .background(Material.ultraThickMaterial)
            .clipShape(Circle())
        } else {
            Button(action: {
                dismiss.callAsFunction()
            }, label: {
                Image(systemName: "chevron.left")
            })
            .matchedGeometryEffect(id: "leadingButt", in: headerSnap)
            .padding(5)
        }
    }
    
    @ViewBuilder
    private var trailingButton: some View {
        if currentSnapPos == .extended {
            Button("Change") {
                changeButton()
            }
            .matchedGeometryEffect(id: "trailingButt", in: headerSnap)
            .padding(5)
            .background(Material.ultraThickMaterial)
            .clipShape(Capsule())
        } else {
            Button("Change") {
                changeButton()
            }
            .matchedGeometryEffect(id: "trailingButt", in: headerSnap)
            .padding(5)
        }
    }
    
    private var scalingHeaderScrollView: some View {
        ScalingHeaderScrollView {
            ProfileHeader(currentSnapPos: $currentSnapPos, headerSnap: headerSnap)
        } content: {
            ProfileContent()
        }
        .scrollOffset($scrollOffset)
        .collapseProgress($progress)
        .headerSnappingPositions(snapPositions: snapPositions)
        .allowsHeaderCollapse()
        .height(min: minHeight, max: maxHeight)
        .hideScrollIndicators()
        .ignoresSafeArea()
    }
    
    private func changeButton() {
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
