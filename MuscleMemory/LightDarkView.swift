//
//  LightDarkView.swift
//  MuscleMemory
//
//  Created by alex haidar on 10/28/24.
//

import SwiftUI

struct LightDarkView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var autoLight = true
    @State private var automatic = false
   
    var body: some View {
        
       
    
        
        VStack(spacing: 20) {
            
            
            Text("Appearence")
                .fontWeight(.semibold)
                .tracking(-1)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.trailing, 20)
                .padding(.bottom, 30)
            
            
            HStack(spacing: 35) {
                VStack {
                    Image("lightPreview")
                    Text("Light")
                    Button(action: {
                        if !autoLight {
                            automatic = false
                        }
                        autoLight = true
                    }) {
                        Circle()
                            .fill(autoLight ? Color.blue : Color.mmBackground)
                            .stroke(Color.gray, lineWidth: 1)
                            .frame(width: 20, height: 20)
                    }
                }
                
                VStack {
                    Image("darkPreview")
                    Text("Dark")
                    
                    Button(action: {
                        if autoLight {
                            automatic = false
                        }
                        autoLight = false
                    }) {
                        Circle()
                            .fill(!autoLight ? Color.blue : Color.mmBackground)
                            .stroke(Color.gray, lineWidth: 1)
                            .frame(width: 20, height: 20)
                    }
                }
            }
            .padding(.bottom, 15)
            .disabled(automatic)
            .opacity(automatic ? 0.4 : 1)
            
            Divider()
                .padding(.horizontal, 20)
            
            HStack {
                Text("Automatic")
                    .fontWeight(.semibold)
                
                
                Toggle("", isOn: $automatic)
                    .onChange(of: automatic) { oldValue, newValue in
                        if newValue {
                            switch colorScheme {
                            case .light:
                                autoLight = true
                            case .dark:
                                autoLight = false
                            @unknown default:
                                break
                            }
                        }
                    }
            }
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mmBackground)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    LightDarkView()
}
