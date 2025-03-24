//
//  test.swift
//  MuscleMemory
//
//  Created by alex haidar on 3/10/25.
//
//FOR TESTING/DEBUGGING PURPOSES ONLY

import SwiftUI
import Foundation
import ActivityKit



struct test: View {
    
    @Environment(\.dismiss) var close
    @State private var maskHeight: CGFloat = 0
    @State private var borderOpacity: Double = 1.0
    @Environment(\.openURL) private var openURLRedirect
    @Environment(\.colorScheme) var colorScheme
    private var elementOpacityDark: Double { colorScheme == .dark ? 0.1 : 0.5 }
    private var textOpacity: Double { colorScheme == .dark ? 0.8 : 0.8 }
    @State private var closeView = false
    
    var body: some View {
        
        Button {
            DynamicRepAttribute.staticAttribute.startDynamicRep(titleName: "title here", contentBody: "content body here")
        } label: {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 25, height: 25)
        }
        
        Button {
            DynamicRepAttribute.staticAttribute.updateDynamicRep(titleName: "title", contentBody: "content")
        } label: {
            Rectangle()
            .fill(Color.yellow)
            .frame(width: 25, height: 25)
        }
        
        Button {
            DynamicRepAttribute.staticAttribute.killDynamicRep(titleName: "updated title", contentBody: "updated content")
        } label: {
            Rectangle()
            .fill(Color.red)
            .frame(width: 25, height: 25)
        }
        
        Button {     //TESTING FEEDING DATA TO DYNAMICREP
            maskHeight = 0
            borderOpacity = 1.0
            
            
            withAnimation(.easeInOut(duration: 0.1)) {
                maskHeight = 60
            } completion: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.linear(duration: 0.2)) {
                        borderOpacity = 0.0
                    } completion: {
                        maskHeight = 0
                    }
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                if let redirect = URL(string: "https://api.notion.com/v1/oauth/authorize?client_id=138d872b-594c-8050-b985-0037723b58e0&response_type=code&owner=user&redirect_uri=https%3A%2F%2Fnotionauthbridge-rhuwa73w2a-uc.a.run.app%2Fcallback%3Fcode%3DAUTHORIZATION_CODE") {
                    openURLRedirect(redirect)
                }
                close()
                
            }
        } label: {
         
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: 297, height: 43)
                .foregroundStyle(Color.white)
                .opacity(0.75)
            
                .padding(3)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.white, lineWidth: 2)
                        .opacity(borderOpacity)
                        .blur(radius: 0.5)
                        .mask(
                            VStack {
                                Rectangle()
                                    .frame(width: 350, height: maskHeight)
                                Spacer()
                            }
                                .blur(radius: 2)
                        )
                     )
                  }
              }
          }

#Preview {
    test()
}
