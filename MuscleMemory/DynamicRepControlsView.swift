//
//  DynamicRepControlsView.swift
// import SwiftUI
import SwiftData
import Supabase
import OSLog


fileprivate struct FrequencyOption: Identifiable {
    var id: String { label }
    let label: String
    let interval: DateComponents
    
    init(label: String, interval: DateComponents) {
        self.label = label
        self.interval = interval
    }
}

struct QueryIDs: Codable {
    let id: Int
}

struct Offset: Codable {
    let offset_date: Date
}


struct DynamicRepControlsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    private var elementOpacityDark: Double { colorScheme == .dark ? 0.1 : 0.5 }
    private var textOpacity: Double { colorScheme == .dark ? 0.8 : 0.8 }
    
    @Environment(\.modelContext) var modelContextPage
    
    @Query var pageContent: [UserPageContent]
    @Query var pageTitle: [UserPageTitle]
    
    @State var drag: CGFloat = -160
    @State var fullDrag: CGFloat = 0
    
    let frequencyStopsPositions: [CGFloat] = [-160, -70, 28, 151]
    let autoDisableStopsPositions: [CGFloat] = [-160, -13, 146]
    fileprivate let frequencyOptions: [FrequencyOption] = [.init(label: "Off", interval: DateComponents(minute: 1)),
                                                           .init(label: "1hr", interval: DateComponents(minute: 60)),
                                                           .init(label: "2.5hrs", interval: DateComponents(hour: 2, minute: 30)),
                                                           .init(label: "3.4hrs", interval: DateComponents(hour: 3, minute: 40))]
    
    
    @State var dragOne: CGFloat = -160
    @State var fullDragOne: CGFloat = 0
    
    private var pageContentElements: [String] {
        pageContent.compactMap { $0.userContentPage }
    }
    
    private var joinStrings: [String] {
        pageContentElements.compactMap { $0 }
    }
    
    
    
    func liveActivityTrigger() async {
        do {
            ImportUserPage.shared.modelContextPagesStored(pagesContext: modelContextPage)
            try await ImportUserPage.shared.pageEndpoint()
        } catch {
            print("error fetching persisted page data")
        }
        DynamicRepAttribute.staticAttribute.startDynamicRep(plain_text: pageTitle.first?.plain_text, userContentPage: joinStrings)
    }
    
    func teardownTrigger() async {
        DynamicRepAttribute.staticAttribute.killDynamicRep(plain_text: pageTitle.first?.plain_text, userContentPage: joinStrings)
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
                                    let clamped = min(max(proposed, frequencyStopsPositions.first!), frequencyStopsPositions.last!)
                                    drag = clamped - fullDrag
                                }
                                .onEnded { _ in
                                    
                                    let endPosition = fullDrag + drag
                                    let nearest = frequencyStopsPositions.min { abs($0 - endPosition) < abs($1 - endPosition) }!
                                    
                                    
                                    withAnimation(.spring(response: 0.4, dampingFraction: 1)) {
                                        fullDrag = nearest
                                        drag = 0
                                    }
                                    
                                    if let index = frequencyStopsPositions.firstIndex(of: nearest) {
                                        let selectedOption = frequencyOptions[index]
                                        let now = Date()
                                        let computedOffset: Date? = selectedOption.label == "Off" ? nil : Calendar.current.date(byAdding: selectedOption.interval, to: now)
                                        
                                        Task {
                                            
                                            do {
                                                let selectQuery: PostgrestResponse<[QueryIDs]> = try await supabaseDBClient.from("push_tokens").select("id").execute()
                                                let result = selectQuery.value
                                                let queryID = result.map(\.id)
                                                print("ID HERE: \(queryID)")
                                                
                                                if selectedOption.label == "Off" {
                                                    do {
                                                        let disable = try await supabaseDBClient.from("push_tokens").update(["offset_date" : "1970-01-01T00:00:00Z"]).in("id", values: queryID).execute()
                                                        print("slider off: \(disable)")
                                                    } catch {
                                                        print("failed to disable: \(error)")
                                                    }
                                                }
                                                
                                                do {
                                                    let send = try await supabaseDBClient.from("push_tokens").update(["offset_date" : computedOffset]).in("id", values: queryID).execute()
                                                    print("OFFSET DATE SENT TO SUPABASE: \(send.value)")
                                                } catch {
                                                    print("failed to send offset date to supabase ❗️: \(error)")
                                                }
                                            } catch {
                                                print("failed to query id's from supabase ❌: \(error)")
                                            }
                                            
                                            await liveActivityTrigger()
                                            print("option selected: \(selectedOption)")
                                            
                                        }
                                        
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
                    ForEach(frequencyOptions) { frequencyOption in
                        Text(frequencyOption.label)
                            .fontWeight(.semibold)
                            .opacity(textOpacity)
                    }
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
                                            let clamped = min(max(proposed, autoDisableStopsPositions.first!), autoDisableStopsPositions.last!)
                                            dragOne = clamped - fullDragOne
                                        }
                                        .onEnded { _ in
                                            
                                            let endPosition = fullDragOne + dragOne
                                            let nearest = autoDisableStopsPositions.min { abs($0 - endPosition) < abs($1 - endPosition) }!
                                            
                                            
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
                                
                            }.offset(x: 9, y: -41)
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
        .background(Color.mmBackground)
        .navigationBarBackButtonHidden()
        
    }
}


#Preview {
    DynamicRepControlsView()
}

