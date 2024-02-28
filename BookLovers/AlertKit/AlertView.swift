//
//  AlertView.swift
//  BookLovers
//
//  Created by Yanis on 28.02.2024.
//

import SwiftUI

struct AlertView: View{
    @Binding var isPresented: Bool
    
    @State private var timer: Timer?
    @State private var offset = CGSize()
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                if isPresented {
                    VStack {
                        HStack {
                            Image(systemName: "antenna.radiowaves.left.and.right.slash")
                            Text("No Internet connection")
                        }
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                    }
                    .padding(12)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
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
                    .onChanged { gesture in
                        if offset.height <= 40 {
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8)) {
                                offset = gesture.translation
                            }
                        }
                        timer?.invalidate()
                    }
                    .onEnded { _ in
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

extension View {
    @ViewBuilder
    func alertToast(isPresented: SwiftUI.Binding<Bool>) -> some View {
        ZStack {
            self
            AlertView(isPresented: isPresented)
                .animation(.easeIn(duration: 0.2), value: isPresented.wrappedValue)
        }
    }
}

struct AlertTestView: View {
    @State var show = false
    
    var body: some View {
        Button("show") {
            show.toggle()
        }
        .alertToast(isPresented: $show)
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertTestView()
    }
}
