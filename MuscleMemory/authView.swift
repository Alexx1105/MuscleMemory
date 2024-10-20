//
//  authView.swift
//  MuscleMemory
//
//  Created by alex haidar on 10/12/24.
//

import SwiftUI
import AuthenticationServices
import Foundation

struct authView: View {
    var body: some View {
        
        
        VStack {
          
            Spacer()
            Image("auth")
                .resizable()
                .scaledToFit()
                .frame(width: 330, height: 330)
                .padding(.trailing, 10)
                .padding(.top, 60)
          
            Spacer()
            Text("Sign into MuscleMemory ")
                .fontWeight(.bold)
                .font(.system(size: 16))
                .padding(.trailing, 70)
                .padding(.bottom, 1)
         
            Text("Powered by Kimchi Labs  ")
                .fontWeight(.medium)
                .foregroundStyle(Color.gray)
                .font(.system(size: 14))
                .padding(.trailing, 90)
       
            Divider()
                .frame(width: 360, height: 1)
              
                .padding(.bottom, 4)
            SignInWithAppleButton(.signIn, onRequest: {_ in}, onCompletion: {_ in})
                .frame(width: 297, height:  43)
                .cornerRadius(20)
                .padding(.bottom, 130)
            
        } .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        
        
        
        
    }
}
    
    #Preview {
        authView()
    }

