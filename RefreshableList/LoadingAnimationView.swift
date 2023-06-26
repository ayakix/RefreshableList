//
//  LoadingAnimationView.swift
//  RefreshableList
//
//  Created by Ryota Ayaki on 2023/06/26.
//

import Lottie
import SwiftUI

struct LoadingAnimationView: UIViewRepresentable {
    func makeUIView(context _: UIViewRepresentableContext<LoadingAnimationView>) -> UIView {
        let view = UIView(frame: .zero)
        // download from
        // https://lottiefiles.com/147412-loading-or-typing-bubbles
        let animationView = LottieAnimationView(name: "loading")
        animationView.loopMode = .loop
        animationView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        animationView.play()

        return view
    }

    func updateUIView(_: UIView, context _: UIViewRepresentableContext<LoadingAnimationView>) {}
}

struct LoadingAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingAnimationView()
            .frame(width: 100, height: 100)
            .background(.black)
    }
}
