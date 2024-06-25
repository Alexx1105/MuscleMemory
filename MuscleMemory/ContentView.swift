//
//  ContentView.swift
//  MuscleMemory
//
//  Created by alex haidar on 4/13/24.
//

import SwiftUI
import WidgetKit
import ActivityKit
import UIKit


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


struct ContentView: View {
    
    class NotionCall: ObservableObject {
        @Published var makeapirequest: [BlockBody.Block] = []
        
        func makeAPIRequest() {
            
            makeRequest { data in
                self.makeapirequest = data
                
                
            }
        }
        
    }
    
    
    @StateObject var NotionCaller = NotionCall()   //manage lifecycle of instance
    
    @State var searchKeywords = String()    //modify text field to search keywords later
   
    @State var menuFunc = String()   //modify to take user back to menu later
    @State var notificationSettings = String() //modify to take user to notifications settings page later
    @State var importNotionFile = String() //modify for user to be able to import their notion file for parsing
 
    var body: some View {
    
            NavigationStack {
                
                
                ZStack {
                    
                    Color(hex: "#f9f9f9")
                        .ignoresSafeArea()
                    
                    
                    
                    VStack {
                       
                        
                        TextField("   Search keywords", text: $searchKeywords)  //change font later
                            .frame(height: 48)
                            .overlay(RoundedRectangle(cornerRadius: 30).strokeBorder(style: StrokeStyle()))
                            .foregroundColor(.white)
                            .background(.white)
                            .cornerRadius(30)
                            .padding()
                            .scaledToFit()
                            .frame(maxHeight: .infinity, alignment: .top)
                        
                        List(NotionCaller.makeapirequest) { textBlock in
                            if let unwrapFields = textBlock.paragraph {
                                ForEach(unwrapFields.richText) { richText in
                                    if let plainTextValue = richText.PlainText {
                                        Text(plainTextValue)
                                    }
                                }
                            }
                        }
                        
                        Divider()
                            .frame(maxHeight: .infinity, alignment: .bottom)
                            .padding()
                            .padding(.bottom)
                            .padding()
    
                        
                            .onAppear {
                                NotionCaller.makeAPIRequest()
                        }
                    }
                    
                    
                    
                    HStack {
                        
                        Button(action: {              //add functionality later
                        }) {
                            
                            Image("menuButton")
                                .frame(maxHeight: .infinity, alignment: .bottom)
                                .padding(.horizontal, 42)
                            Spacer()
                            
                        }
                        
                        HStack {
                            Button(action: {              //add functionality later
                            }) {
                                
                                Image("notificationButton")
                                    .frame(maxHeight: .infinity, alignment: .bottomLeading)
                                    .padding(.leading, 30)
                                Spacer()
                            
                            }
                        }
                        
                        HStack {
                            Button(action: {
                            }) {
                                Image("notionImportButton")
                                    .frame(maxHeight: .infinity, alignment: .bottom)
                                    .padding(.horizontal)
                                    .padding(.horizontal)
                        }
                        }
                    }
                            
                        
                    }
                
                }
                
            }
            
        }
        
    

    
#Preview {
    ContentView()
}
