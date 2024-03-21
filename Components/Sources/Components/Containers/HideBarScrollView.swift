//
//  HideBarScrollView.swift
//  BookLovers
//
//  Created by Yanis on 14.03.2024.
//

import SwiftUI
#if os(macOS)
#else
public struct HideBarScrollView<Content>: View where Content : View {
    private var axis: Axis.Set
    private var showIndicator: Bool
    @Binding private var barState: Visibility
    private var content: Content
    
    public init(
        axis: Axis.Set = .vertical,
        showIndicator: Bool = true,
        barState: Binding<Visibility>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.axis = axis
        self.showIndicator = showIndicator
        self._barState = barState
        self.content = content()
    }
    
    public var body: some View {
        ScrollView(axis, showsIndicators: showIndicator, content: {content})
            .background(PanGestureView(onChange: handleState(_:)))
    }
    
    private func handleState(_ gesture: UIPanGestureRecognizer) {
        //let offsetY = gesture.translation(in: gesture.view).y
        let velocityY = gesture.velocity(in: gesture.view).y
        
        if velocityY < 0 {
            ///swiping up
            if -(velocityY / 5) > 60 && barState == .visible {
                barState = .hidden
            }
        } else {
            ///swiping down
            if (velocityY / 5) > 40 && barState == .hidden {
                barState = .visible
            }
        }
    }
}

// MARK: - UIView with Pan gesture for hide bars

fileprivate struct PanGestureView: UIViewRepresentable {
    var onChange: (UIPanGestureRecognizer) -> ()
    private let gestureID = UUID().uuidString
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(onChange: onChange)
    }
    
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        Task { @MainActor in
            if let superView = uiView.superview?.superview,
               !(superView.gestureRecognizers?.contains(where: { $0.name == gestureID }) ?? false) {
                let gesture = UIPanGestureRecognizer(
                    target: context.coordinator,
                    action: #selector(context.coordinator.gestureChange(_:)))
                gesture.name = gestureID
                gesture.delegate = context.coordinator
                superView.addGestureRecognizer(gesture)
            }
        }
    }
    
    class Coordinator: NSObject, UIGestureRecognizerDelegate {
        var onChange: (UIPanGestureRecognizer) -> ()
        
        init(onChange: @escaping (UIPanGestureRecognizer) -> ()) {
            self.onChange = onChange
        }
        
        @objc
        func gestureChange(_ gesture: UIPanGestureRecognizer) {
            onChange(gesture)
        }
        
        func gestureRecognizer(
            _ gestureRecognizer: UIGestureRecognizer,
            shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
        ) -> Bool {
            return true
        }
    }
}
#endif
