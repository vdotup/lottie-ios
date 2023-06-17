//
//  LottieView.swift
//  lottie-swift-iOS
//
//  Created by vdotup on 14/06/2023.
//

import SwiftUI
/// SwiftUI UIViewRepresentable for LottieAnimationView.
@available(iOS 13.0, *)
public struct LottieView: UIViewRepresentable {
    
    @ObservedObject private var helper = LottieViewHelper()
    
    public let name: String
    public let contentMode: UIView.ContentMode
    public let animationView: LottieAnimationView
    
    public init(name: String, contentMode: UIView.ContentMode = .scaleAspectFit) {
        self.name = name
        self.contentMode = contentMode
        self.animationView = LottieAnimationView(name: name)
    }
    
    public func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.addSubview(animationView)
        animationView.contentMode = contentMode
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        animationView.loopMode = helper.loopMode
        animationView.animationSpeed = helper.animationSpeed
        animationView.play()
        
        return view
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {}
    
}

@available(iOS 13.0, *)
extension LottieView {
    
    class LottieViewHelper: ObservableObject {
        @Published internal var loopMode: LottieLoopMode = .loop
        @Published internal var animationSpeed: CGFloat = 1.0
    }
    
    public func loopMode(_ loopMode: LottieLoopMode = .loop) -> Self {
        self.helper.loopMode = loopMode
        return self
    }
    
    public func animationSpeed(_ animationSpeed: CGFloat = 1.0) -> Self {
        self.helper.animationSpeed = animationSpeed
        return self
    }
}
