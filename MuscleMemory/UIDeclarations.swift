//
//  declarations.swift
//  MuscleMemory
//
//  Created by alex haidar on 10/13/24.
//

import Foundation
import AuthenticationServices
import SwiftUI
import UIKit

let controller = authController()
public class authController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(appleSignIn)
    }
    let appleSignIn = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    
}
    public struct AuthControllerRepresentable: UIViewControllerRepresentable {
        public func makeUIViewController(context: Context) -> authController {
           
            return authController()
        }
        
        public func updateUIViewController(_ uiViewController: authController, context: Context) {
            
        }
    }


