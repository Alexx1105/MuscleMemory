//
//  NotionImportPageView.swift
//  MuscleMemory
//
//  Created by alex haidar on 10/26/24.
//

import SwiftUI

struct NotionImportPageView: View {
    var body: some View {
        VStack {
         
            Spacer()
            Rectangle()
                .frame(width: 370, height: 228)
                .cornerRadius(30)
                .foregroundStyle(Color.white)
                .overlay {
                    Text("Import notes from your notion")
                        .fontWeight(.semibold)
                        .padding(.bottom, 170)
                    
                    Image(systemName: "tray.and.arrow.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .padding(.bottom,20 )
                    
                    Image("notion")
                        .padding(.top, 155)
                        .padding(.trailing, 110)
                    
                    Text("Import page")
                        .fontWeight(.medium)
                        .padding(.top, 155)
                        .padding(.leading, 29)
                    
                    Button(action: { }) {     //modify to import notion page later, possibly trigger a class in NotionCall.swift
                        
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(Color.black, lineWidth: 1)
                                .frame(width: 297, height: 43)
                                .foregroundStyle(Color.white)
                                .padding(.top, 157)
                                
                    }
                }
            
            Spacer()
            Divider()
                .padding()
          
            HStack {
                
                    Button(action: {              //add functionality later
                    }) {
                        Image("menuButton")
                    }
                    .frame(maxWidth: .infinity)
                    
                
                    NavigationLink(destination: SettingsView()) {
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.mmBackground)
    }
}

#Preview {
    NotionImportPageView()
}
