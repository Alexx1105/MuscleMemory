//
//  NotionImportPageView.swift
//  MuscleMemory
//
//  Created by alex haidar on 10/26/24.
//

import SwiftUI

struct NotionImportPageView: View {
    @Environment(\.dismiss) var close 
    @State private var maskHeight: CGFloat = 0
    @State private var borderOpacity: Double = 1.0
    @Environment(\.openURL) private var openURLRedirect
    @Environment(\.colorScheme) var colorScheme
    private var elementOpacityDark: Double { colorScheme == .dark ? 0.1 : 0.5 }
    private var textOpacity: Double { colorScheme == .dark ? 0.8 : 0.8 }
    @State private var closeView = false
    
    var body: some View {
        
       
        
        VStack {
            
            HStack {
                
                NavigationLink(destination: MainMenu()) {
                    Image(systemName: "arrow.backward").foregroundStyle(Color.white.opacity(0.8))
                }
                
                Spacer()
                
                
               
            }
            .frame(maxWidth: 370)
            .padding(.top, 5)
            
            
            Spacer()
            ZStack(alignment: .center) {
                
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 370, height: 228)
                    .foregroundStyle(Color.white)
                    .opacity(elementOpacityDark)
                    .overlay(RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white, lineWidth: 0.2)
                        .opacity(0.50)
                    )
                
                
                
                
                Text("Import notes from your notion")
                    .fontWeight(.semibold)
                    .opacity(textOpacity)
                    .padding(.bottom, 160)
                
                HStack {
                    Image(systemName: "tray.and.arrow.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .opacity(textOpacity)
                        .padding(.bottom, 60)
                    
                }
                .padding(.trailing, 200)
                
                Text("Grant Notion access \nto your account.")
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .opacity(0.25)
                    .padding(.horizontal)
                    .padding(.leading, 20)
                    .padding(.bottom, 60)
                
                
                
                VStack {
                    
                    ZStack {
                        
                        Rectangle()
                            .frame(width: 320, height: 0.4)
                            .opacity(0.2)
                            .padding(.bottom, 70)
                        
                        Button {
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
                        
                        Text("Import page")
                            .foregroundStyle(Color.black)
                            .fontWeight(.medium)
 
                    }
                    .padding(.top, 150)
                }
                
            }
            
            Spacer()
            Divider()
                .padding()
            
            HStack {
                
                NavigationLink(destination: MainMenu()) {
                    Image("menuButton")
                }
                .frame(maxWidth: .infinity)
                
                
                NavigationLink(destination: SettingsView()) {
                    Image("settingsButton")
                    
                }
                .frame(maxWidth: .infinity)
                
                NavigationLink(destination: NotionImportPageView()) {
                    Image("notionImportButton")
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.mmBackground)
        .navigationBarBackButtonHidden()
        
    }
}

#Preview {
    NotionImportPageView()
}

