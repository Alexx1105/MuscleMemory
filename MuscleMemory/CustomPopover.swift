//
//  CustomPopover.swift
//  MuscleMemory
//
//  Created by alex haidar on 2/5/25.
//NOTE: nvm apple doesnt let us change the Menu {} style, we'll save this custom view for something else later on

import SwiftUI
import UIKit




struct BlurView: UIViewRepresentable {
   
    func makeUIView(context: Self.Context) -> UIView {
   
        let effect = UIBlurEffect(style: .systemUltraThinMaterialDark)
    let returnEffectView = UIVisualEffectView(effect: effect)
    return returnEffectView
    }
   
    func updateUIView(_ uiView:  UIView, context: Context ) {}
}

