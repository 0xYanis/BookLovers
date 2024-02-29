import SwiftUI

public extension View {
    func alertToast<Figure, Background, Content>(
        isPresented: SwiftUI.Binding<Bool>,
        shape: Figure,
        background: Background,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Figure : Shape, Background : ShapeStyle, Content : View {
        ZStack {
            self
            
            AlertToastItem(
                isPresented: isPresented,
                shape: shape,
                background: background,
                content: content
            )
            .animation(.easeIn(duration: 0.2), value: isPresented.wrappedValue)
        }
    }
    
    func alertToast<Content>(
        isPresented: SwiftUI.Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content : View {
        ZStack {
            self
            
            AlertToastItem(
                isPresented: isPresented,
                shape: RoundedRectangle(cornerRadius: 12),
                background: Color(.secondarySystemBackground),
                content: content
            )
            .animation(.easeIn(duration: 0.2), value: isPresented.wrappedValue)
        }
    }
    
    func alertToast(
        isPresented: SwiftUI.Binding<Bool>,
        systemImage: String,
        message: String
    ) -> some View {
        ZStack {
            self
            
            AlertToastItem(
                isPresented: isPresented,
                shape: RoundedRectangle(cornerRadius: 12),
                background: Color(.secondarySystemBackground)) {
                    HStack {
                        Image(systemName: systemImage)
                        Text(message)
                    }
                    .font(.callout)
                    .foregroundStyle(.secondary)
                }
                .animation(.easeIn(duration: 0.2), value: isPresented.wrappedValue)
        }
    }
    
    func alertToastProgress(
        isPresented: SwiftUI.Binding<Bool>,
        message: String? = nil
    ) -> some View {
        ZStack {
            self
            
            AlertToastItem(
                isPresented: isPresented,
                shape: RoundedRectangle(cornerRadius: 12),
                background: Color(.secondarySystemBackground)) {
                    HStack {
                        ProgressView()
                        if let text = message {
                            Text(text).padding(.leading, 2)
                        }
                    }
                    .font(.callout)
                    .foregroundStyle(.secondary)
                }
                .animation(.easeIn(duration: 0.2), value: isPresented.wrappedValue)
        }
    }
}
