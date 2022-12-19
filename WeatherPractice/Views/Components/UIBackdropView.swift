//
//  UIBackdropView.swift
//  WeatherPractice
//
//  Created by Mubeen Khalid on 19/12/2022.
//

import SwiftUI


class Blur: UIView {
    override class var layerClass: AnyClass {
        NSClassFromString("CABackdropLayer") ?? CALayer.self
    }
}

struct BackDrop: UIViewRepresentable {
    func makeUIView(context: Context) -> Blur {
        Blur()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct UIBackdropView: View {
    var radius: CGFloat = 3
    var opaque: Bool = false
    var body: some View {
        BackDrop()
        .blur(radius: radius, opaque: opaque)
    }
}

struct UIBackdropView_Previews: PreviewProvider {
    static var previews: some View {
        UIBackdropView()
    }
}
