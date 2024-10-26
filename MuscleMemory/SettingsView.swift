//
//  SettingsView.swift
//  MuscleMemory
//
//  Created by alex haidar on 10/23/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
      
        NavigationStack {
            
            VStack {
                
                Spacer()
                Rectangle()
                    .frame(width: 370, height: 78)
                    .cornerRadius(18)
                    .padding(.bottom, 250)
                    .foregroundStyle(.white)
                    .overlay {
                       
                        Text("Settings")
                            .padding(.bottom, 430)
                            .padding(.trailing, 300)
                            .fontWeight(.semibold)
                        
                        Button(action:  {
                        }) { Text("Log out")
                                .fontWeight(.regular)
                                .foregroundStyle(Color.gray)
                                .padding(.bottom, 430)
                                .padding(.leading, 280)
                        }  //map to logout later
                        
                        Image(systemName: "clock.badge.exclamationmark")
                            .padding(.bottom, 288)
                            .padding(.trailing, 330)
                      
                        Text("Live flashcards")
                            .padding(.bottom, 290)
                            .padding(.trailing, 170)
        
                        Divider()
                            .padding(.bottom, 250)
                            .frame(width: 340)
                            .padding(.leading, 30)
                        
                        Image(systemName: "circle.lefthalf.filled")
                            .padding(.bottom, 210)
                            .padding(.trailing, 330)
                        
                        Text("Appearence")
                            .padding(.bottom, 212)
                            .padding(.trailing, 190)
                    }
              
                Spacer()
                VStack {
                    Divider()
                        .padding()
                    
                    HStack {
                        
                        Button(action: {              //add functionality later
                        }) {
                            Image("menuButton")
                        }
                        .frame(maxWidth: .infinity)
                        
                        Button(action: {              //add functionality later
                        }) {
                            Image("settingsButton")
                        }
                        .frame(maxWidth: .infinity)
                        
                        Button(action: {
                        }) {
                            Image("notionImportButton")
                        }
                        .frame(maxWidth: .infinity)
                        
                        .padding(.horizontal)
                    }
                }
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.mmBackground)
        }
        }
    }
       


#Preview {
    SettingsView()
}
