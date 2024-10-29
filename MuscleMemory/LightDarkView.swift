//
//  LightDarkView.swift
//  MuscleMemory
//
//  Created by alex haidar on 10/28/24.
//

import SwiftUI

struct LightDarkView: View {
    @State private var autoDarkLight = true
    var body: some View {
        
        VStack {
            Text("Light/Dark mode")            //add navigation view to go back later
                .fontWeight(.semibold)
                .tracking(-1)
                .padding(.bottom, 500)
                .padding(.leading, 230)
               
                .overlay {
                    Image("lightPreview")
                        .padding(.bottom, 90)
                        .padding(.trailing, 180)
                    Text("Light")
                        .padding(.top, 245)
                        .padding(.trailing, 180)
                    
                    Button(action: {}) {
                        Circle()
                            .fill(Color.mmBackground)
                            .stroke(Color.gray, lineWidth: 1)
                            .frame(width: 20, height: 20)
                            .padding(.top,310)
                            .padding(.trailing, 181)
                        
                    }
                    
                    Image("darkPreview")
                        .padding(.bottom, 90)
                        .padding(.leading, 180)
                    Text("Dark")
                        .padding(.top, 245)
                        .padding(.leading, 180)
                    
                    Button(action: {}) {
                        Circle()
                            .fill(Color.mmBackground)
                            .stroke(Color.gray, lineWidth: 1)
                            .frame(width: 20, height: 20)
                            .padding(.top,310)
                            .padding(.leading, 180)
                        }
                    
                     Divider()
                        .padding(.top, 400)
                    
                    Text("Automatic")
                        .padding(.top, 470)
                        .padding(.trailing, 250)
                        .fontWeight(.semibold)
                    
            
                    Toggle("", isOn: $autoDarkLight)
                        .padding(.top, 470)
                
                    if autoDarkLight {
                        Text("")             //placeholder for now
                        
                
                    }
                }
           
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mmBackground)
    }
}

#Preview {
    LightDarkView()
}
