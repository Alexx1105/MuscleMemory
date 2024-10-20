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



let controller = viewController()
public class viewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(appleSignIn)
    }
    let appleSignIn = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    
    public class authController: ASAuthorizationController, ASAuthorizationControllerDelegate {
        init() {
            let authRequest = ASAuthorizationAppleIDProvider()
            let formRequest = authRequest.createRequest()
            let authControlRequests = ASAuthorizationController(authorizationRequests: [formRequest])
            super.init(authorizationRequests: [formRequest])
        }
        
        public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization ) {
            print("auth type:\(authorization)")
        }
        public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
            print("authorization was not succuessful or no data was returned\(error)")
        }
        func checkResult(authorization: ASAuthorization?, error: Error?) {          //helper func for handling both delegate funcs above 
            if let authResult = authorization {
                print("auth successful\(authResult)")
            } else if let authFailure = error {
                print("authorization was not succuessful or no data was returned\(authFailure)")
            }
        }
    }
}

     

    public struct AuthControllerRepresentable: UIViewControllerRepresentable {
        public func makeUIViewController(context: Context) -> viewController {
        
            return viewController()
        }
        
        public func updateUIViewController(_ uiViewController: viewController, context: Context) {
            
        }
    }


