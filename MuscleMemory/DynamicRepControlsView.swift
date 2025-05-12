//
//  DynamicRepControlsView.swift
//  MuscleMemory
//
//  Created by alex haidar on 5/4/25.
//

import SwiftUI
import SwiftData


struct DynamicRepControlsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    private var elementOpacityDark: Double { colorScheme == .dark ? 0.1 : 0.5 }
    private var textOpacity: Double { colorScheme == .dark ? 0.8 : 0.8 }
    
    @Environment(\.modelContext) var modelContextPage
    
    @Query var pageContent: [UserPageContent]
    @Query var pageTitle: [UserPageTitle]
    
    @State var drag: CGFloat = 0
    @State var fullDrag: CGFloat = 0
    
    let stops: [CGFloat] = [-160, -70, 28, 151]
    let stopsOne: [CGFloat] = [-160, -13, 146]
    
    @State var dragOne: CGFloat = 0
    @State var fullDragOne: CGFloat = 0
    
    let timers = DynamicRepScheduler()
    
    let activeTimerObjects: [Timer]
    init(activeTimerObjects: [Timer] = []) {
        self.activeTimerObjects = activeTimerObjects
    }
    
    func liveActivityTrigger() async {
        do {
            ImportUserPage.shared.modelContextPagesStored(pagesContext: modelContextPage)
            try await ImportUserPage.shared.pageEndpoint()
        } catch {
            print("error fetching persisted page data")
        }
        
        var pageContentElements: [String] = []
        for element in pageContent {
            if let elements = element.userContentPage {
                pageContentElements.append(elements)
            } else {
                print("elements could not be appended to non optional array")
            }
        }
        
        
        let joinStrings = pageContentElements.joined()
        DynamicRepAttribute.staticAttribute.startDynamicRep(plain_text: pageTitle.first?.plain_text, userContentPage: joinStrings)
        
    }
    
    

    var body: some View {
        VStack(spacing: 70) {
            
            HStack(alignment: .top, spacing: 100) {
                
                NavigationLink(destination: MainMenu()) {
                    Image(systemName: "arrow.backward").foregroundStyle(Color.white.opacity(0.8))
                }
                
                VStack(alignment: .trailing ,spacing: 5) {
                    Text("DynamicRep flashcard controls")
                        .fontWeight(.semibold)
                        .opacity(textOpacity)
                    
                    if let title = pageTitle.first?.plain_text {
                        
                        Text("\(title)")
                            .font(.system(size: 16)).lineSpacing(3)
                            .fontWeight(.medium)
                            .opacity(0.25)
                    }
                }
            }
            
            
            VStack(spacing: 5) {
                HStack(alignment: .top) {
                    Text("Frequency")
                        .fontWeight(.semibold)
                        .opacity(textOpacity)
                    
                    Spacer()
                }
                .padding(.leading, 15)
                
                HStack(alignment: .top) {
                    Text("Control how often you receive flashcard repetition\nnotifications containing your notes.")
                        .font(.system(size: 16)).lineSpacing(3)
                        .fontWeight(.medium)
                        .opacity(0.25)
                        .padding(.leading, 1)
                }
                
                ZStack(alignment: .top) {
                    
                    Circle()
                        .foregroundStyle(Color.blue)
                        .frame(width: 42, height: 42)
                        .offset(x: fullDrag + drag, y: 9)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
          
                                    let proposed = fullDrag + value.translation.width
                                    let clamped = min(max(proposed, stops.first!), stops.last!)
                                    drag = clamped - fullDrag
                                }
                                .onEnded { _ in
                 
                                    let endPosition = fullDrag + drag
                                    let nearest = stops.min { abs($0 - endPosition) < abs($1 - endPosition) }!
                                    
                             
                                    withAnimation(.spring(response: 0.4, dampingFraction: 1)) {
                                        fullDrag = nearest
                                        drag = 0
                                    }
                                    
                                    switch nearest {
                                    case stops[0]: timers.stopTimer(storeTimer: timers.controlTimer.first!)
                                        
                                    case stops[1]: timers.startTimer(interval: 3600) {
                                        Task { await liveActivityTrigger() }
                                    }
                                        
                                    case stops[2]: timers.startTimer(interval: 8280.0) {
                                        Task { await liveActivityTrigger() }
                                    }
                                    case stops[3]: timers.startTimer(interval: 12240.0) {
                                        Task { await liveActivityTrigger() }
                                    }
                                    default: break
                                    }
                                })
                    
                            
                    RoundedRectangle(cornerRadius: 50)
                        .frame(width: 370, height: 50)
                        .opacity(0.06)
                        .padding(.top, 5)
                }
                
                .overlay {
                    
                    HStack(spacing: 80) {
                        Image(systemName: "multiply.circle").foregroundStyle(Color.white).offset(x: -10)
                        Image(systemName: "clock.arrow.trianglehead.2.counterclockwise.rotate.90").foregroundStyle(Color.white).offset(x: -20)
                        Image(systemName: "clock.arrow.trianglehead.2.counterclockwise.rotate.90").foregroundStyle(Color.white).offset(x: -23)
                        Image(systemName: "clock.arrow.trianglehead.2.counterclockwise.rotate.90").foregroundStyle(Color.white)
                    }.offset(y: 3)
                }
                
                
                HStack(alignment: .top, spacing: 65) {
                    Text("Off")
                        .fontWeight(.semibold)
                        .opacity(textOpacity)
                    
                    Text("1hr")
                        .fontWeight(.semibold)
                        .opacity(textOpacity)
                    
                    Text("2.3hrs")
                        .fontWeight(.semibold)
                        .opacity(textOpacity)
                    
                    Text("3.4hrs")
                        .fontWeight(.semibold)
                        .opacity(textOpacity)
                    
                }
            }
            
            Spacer()
            VStack(spacing: 5) {
                
                HStack(alignment: .top) {
                    Text("Auto disable after ")
                        .fontWeight(.semibold)
                        .opacity(textOpacity)
                    
                    Spacer()
                }
                .padding(.leading, 15)
                
                HStack(alignment: .top) {
                    Text(" MuscleMemory will reset after a full iteration over\n this notion page and repeat again unless one these\n settings are enabled.")
                        .font(.system(size: 16)).lineSpacing(3)
                        .fontWeight(.medium)
                        .opacity(0.25)
                        .padding(.leading, 1)
                    
                }
                
                
                ZStack {
                    
                    VStack {
                        
                        ZStack {
                            
                            Circle()
                                .foregroundStyle(Color.blue)
                                .frame(width: 42, height: 42)
                                .offset(x: fullDragOne + dragOne, y: 0)
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                  
                                            let proposed = fullDragOne + value.translation.width
                                            let clamped = min(max(proposed, stopsOne.first!), stopsOne.last!)
                                            dragOne = clamped - fullDragOne
                                        }
                                        .onEnded { _ in
                                 
                                            let endPosition = fullDragOne + dragOne
                                            let nearest = stopsOne.min { abs($0 - endPosition) < abs($1 - endPosition) }!
                                            
                                     
                                            withAnimation(.spring(response: 0.4, dampingFraction: 1)) {
                                                fullDragOne = nearest
                                                dragOne = 0
                                            }
                                        })
                                    
                            
                            RoundedRectangle(cornerRadius: 50)
                                .frame(width: 370, height: 50)
                                .opacity(0.06)
                        }
                        HStack(alignment: .top, spacing: 110) {
                            Text("Off")
                                .fontWeight(.semibold)
                                .opacity(textOpacity)
                            
                            
                            Text("24hrs")
                                .fontWeight(.semibold)
                                .opacity(textOpacity)
                            
                            Text("48hrs")
                                .fontWeight(.semibold)
                                .opacity(textOpacity)
                            
                        }
                        
                        .overlay {
                         
                            HStack(spacing: 140) {
                                Image(systemName: "multiply.circle").foregroundStyle(Color.white).offset(x: -10)
                                Image(systemName: "timer").foregroundStyle(Color.white).offset(x: -23)
                                Image(systemName: "timer").foregroundStyle(Color.white).offset(x: -23)
                                
                            }.offset(x: 9 , y: -41)
                        }
                        
                        Spacer()
                        HStack(alignment: .bottom) {
                            
                            Menu {
                                
                                Button(action: {}) { Label("Bottom to top", systemImage: "arrow.uturn.up")}
                                Button(action: {}) { Label("Top to bottom", systemImage: "arrow.uturn.down")}
                                Text("Iterate page from:")
                                
                            } label: {
                                RoundedRectangle(cornerRadius: 50)
                                    .frame(width: 122, height: 35)
                                    .padding(.leading, 16)
                                    .opacity(0.06)
                                   
                                
                                    .overlay {
                                        HStack(spacing: 20) {
                                            
                                            Text("Order by")
                                                .fontWeight(.medium)
                                                .opacity(textOpacity)
                                            
                                            Image(systemName: "chevron.up.chevron.down")
                                                .opacity(textOpacity)
                                            
                                        }.padding(.leading, 15)
                                        
                                    }
                                  
                                
                                Spacer()
                                
                            }.buttonStyle(PlainButtonStyle())
                            
                            
                        }
                    }
                }
                Spacer()

            }
            
            
            
            VStack {
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
            
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mmBackground)
        .navigationBarBackButtonHidden()
    }
    
}

#Preview {
    DynamicRepControlsView()
}
