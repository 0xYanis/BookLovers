//
//  BottomSheet.swift
//  BookLovers
//
//  Created by Yanis on 07.03.2024.
//

import SwiftUI
import Components

struct BottomSheet<Content>: View where Content : View {
    @Binding private var isPresented: Bool
    private var content: () -> Content
    @State private var offset = CGSize()
    
    init(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isPresented = isPresented
        self.content = content
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                if isPresented {
                    contentView(proxy)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .gesture(
                DragGesture()
                    .onChanged(onChanged(_:))
                    .onEnded(onEnded(_:))
            )
        }
        .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.9), value: isPresented)
    }
    
    private func contentView(_ proxy: GeometryProxy) -> some View {
        content()
            .padding(12)
            .frame(maxWidth: .infinity)
            .frame(height: proxy.size.height * 0.3)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .shadow(color: .black.opacity(0.1), radius: 15)
            .transition(.move(edge: .bottom))
            .offset(y: offset.height)
            .padding()
            .onDisappear {
                offset = .zero
            }
    }
    
    private func onChanged(_ gesture: DragGesture.Value) {
        if offset.height > -10 {
            withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.9)) {
                offset = gesture.translation
            }
        }
    }
    
    private func onEnded(_ gesture: DragGesture.Value) {
        if offset.height <= 70 {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.9)) {
                offset = .zero
            }
        }
        
        if offset.height > 70 {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.9)) {
                isPresented = false
            }
        }
    }
}

extension View {
    func bottomSheet<Content>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content : View {
        ZStack {
            self
            BottomSheet(isPresented: isPresented, content: content)
        }
    }
    
    func bottomSheet(
        isPresented: Binding<Bool>,
        title: String,
        subtitle: String
    ) -> some View {
        ZStack {
            self
            BottomSheet(isPresented: isPresented) {
                VStack(spacing: 15) {
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    
                    Text(subtitle)
                        .font(.callout)
                        .multilineTextAlignment(.center)
                    Spacer()
                    HStack(spacing: 15) {
                        Button("Got it!", role: .destructive) {
                            isPresented.wrappedValue = false
                        }
                        .foregroundStyle(.white)
                        .padding(12)
                        .frame(maxWidth: .infinity)
                        .background(.green)
                        .clipShape(Capsule())
                    }
                    .padding(.bottom, 10)
                }
            }
        }
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.opacity(0.1).ignoresSafeArea()
            BottomSheet(isPresented: .constant(true)) {
                VStack(spacing: 15) {
                    Text("Title")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                        .font(.callout)
                        .multilineTextAlignment(.center)
                    Spacer()
                    HStack(spacing: 15) {
                        
                        
                        Button("Got it!", role: .destructive, action: {})
                            .foregroundStyle(.white)
                            .padding(12)
                            .frame(maxWidth: .infinity)
                            .background(.green)
                            .clipShape(Capsule())
                    }
                    .padding(.bottom, 10)
                }
            }
        }
    }
}
