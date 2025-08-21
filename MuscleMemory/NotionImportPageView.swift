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
                    .background(Material.ultraThin)
                    .frame(width: 370, height: 228)
                    .foregroundStyle(Color.white)
                    .opacity(elementOpacityDark)
                    .overlay(RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white, lineWidth: 0.2)
                   
                       
                    )
                
                HStack(alignment: .top) {
                    VStack(spacing: 20 ) {
                        Text("Import notes from your notion")
                            .fontWeight(.medium)
                            .opacity(textOpacity)
                        
                        Text("Grant Notion access to your\naccount to import your notes")
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                            .opacity(textOpacity)
                            .padding(.horizontal)
                            Spacer()
                    }.frame(maxHeight: 185)
                       
                        
                }
            
                
                
                VStack {
                    
                    ZStack {
                        
                        
                        Button {
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                if let redirect = URL(string: "https://api.notion.com/v1/oauth/authorize?client_id=138d872b-594c-8050-b985-0037723b58e0&response_type=code&owner=user&redirect_uri=https%3A%2F%2Fnotionauthbridge-rhuwa73w2a-uc.a.run.app%2Fcallback%3Fcode%3DAUTHORIZATION_CODE") {
                                    openURLRedirect(redirect)
                                }
                                close()
                                
                            }
                        } label: {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.gray).opacity(0.5)
                                .frame(width: 297, height: 50)
                                .opacity(textOpacity)
                                
                               
                            
                                .padding(3)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(Color.white, lineWidth: 2)
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
                            .opacity(textOpacity)
                            .fontWeight(.medium)
        
 
                    }
                    .padding(.top, 150)
                }
                
            }
            
            Spacer()
           
            
            VStack {
                Divider()
                    .padding(.bottom, 10)
                
                HStack(spacing: 30) {
                    
                    NavigationLink(destination: MainMenu()) {
                        Image("menuButton")
                         
                    }
                    .frame(maxWidth: .infinity)
                    
                    
                    
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(Color.white.opacity(0.8))
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                    NavigationLink(destination: NotionImportPageView()) {
                        Image(systemName: "plus.app")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(Color.white.opacity(0.8))
             
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    
                }
                
            }.background(Material.ultraThin)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.mmBackground)
        .navigationBarBackButtonHidden()
        
    }
}

#Preview {
    NotionImportPageView()
}

