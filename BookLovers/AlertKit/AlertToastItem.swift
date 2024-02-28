//
//  AlertToastItem.swift
//  BookLovers
//
//  Created by Yanis on 29.02.2024.
//

import SwiftUI

struct AlertToastItem<Content, Figure, Background>: View where Content : View, Figure : Shape, Background : ShapeStyle {
    @Binding private var isPresented: Bool
    @State private var timer: Timer?
    @State private var offset = CGSize()
    private var shape: Figure
    private var background: Background
    private var content: () -> Content
    
    init(
        isPresented: SwiftUI.Binding<Bool>,
        shape: Figure,
        background: Background,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isPresented = isPresented
        self.content = content
        self.shape = shape
        self.background = background
    }
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                if isPresented {
                    content()
                    .padding(12)
                    .background(background)
                    .clipShape(shape)
                    .frame(maxWidth: .infinity)
                    .transition(
                        .move(edge: .top)
                        .combined(with: .scale(scale: 0.7))
                        .combined(with: .opacity)
                    )
                    .offset(y: offset.height)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged(onChange(_:))
                    .onEnded { _ in onEnd() }
            )
            .onChange(of: isPresented) { newValue in
                if newValue {
                    resetTimer()
                } else {
                    timer?.invalidate()
                }
            }
        }
    }
    
    private func onChange(_ gesture: DragGesture.Value) {
        if offset.height <= 40 {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8)) {
                offset = gesture.translation
            }
        }
        timer?.invalidate()
    }
    
    private func onEnd() {
        if offset.height > 0 {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8)) {
                offset = .zero
            }
        }
        
        if offset.height < -10 {
            hideAlert()
        }
        
        resetTimer()
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            hideAlert()
        }
    }
    
    private func hideAlert() {
        withAnimation(.easeInOut) {
            isPresented = false
            timer?.invalidate()
            offset = .zero
        }
    }
}
