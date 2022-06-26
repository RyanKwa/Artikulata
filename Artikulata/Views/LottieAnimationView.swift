//
//  LottieAnimationView.swift
//  Artikulata
//
//  Created by Minawati on 25/06/22.
//

import SwiftUI
import Lottie

struct LottieAnimationView: UIViewRepresentable {
    typealias UIViewType = UIView
    let fileName = "Microphone"
    let animationView = AnimationView()
    let isPaused: Bool

    func makeUIView(context: UIViewRepresentableContext<LottieAnimationView>) -> UIView {
        let view = UIView(frame: .zero)

        let animation = Animation.named(fileName)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieAnimationView>) {
        if isPaused {
            context.coordinator.parent.animationView.pause()
        } else {
            context.coordinator.parent.animationView.play()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: LottieAnimationView

        init(_ parent: LottieAnimationView) {
            self.parent = parent
        }
    }
}

struct LottieAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        LottieAnimationView(isPaused: false)
    }
}
