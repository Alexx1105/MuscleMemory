//
//  UXDeclarations.swift
//  MuscleMemory
//
//  Created by alex haidar on 12/7/24.
//

import Foundation
import SwiftUI


    struct animatedBorderStroke: ViewModifier, Animatable {
        private let borderStrokeWidth: Double = 0.1
        @State private var startAtTop: Bool = false
        
        
        var animatableData: Double
        
        func body(content: Content) -> some View {
            content
            .overlay(
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: startAtTop ? 0: 52)
                        .stroke(AngularGradient(stops: [.init(color: .white, location: 0),
                            .init(color: .white, location: 0.1),
                            .init(color: .white, location: 0.4),
                            .init(color: .white, location: 0.5)], center: .center, angle: .degrees(animatableData)))
                            .frame(width: geometry.size.width - CGFloat(borderStrokeWidth), height: geometry.size.height - CGFloat(borderStrokeWidth))
                            .padding(.top, CGFloat(borderStrokeWidth) / 2)
                            .padding(.leading, CGFloat(borderStrokeWidth) / 2)
                    
                            .onAppear {
                                let topArea = geometry.safeAreaInsets.top
                                startAtTop = topArea > 20
                            }
                }
                   
            )
        }
    }



