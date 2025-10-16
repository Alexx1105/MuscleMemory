//
//  LiquidGlassTab.swift
//  MuscleMemory
//
//  Created by alex haidar on 10/14/25.
//

import SwiftUI


struct RootTabs: View {

    var body: some View {
        NavigationStack {
            TabView {
                Tab("Menu", image: "menuButton") {
                   MainMenu(pageID: "pageID")
                }
                Tab("Settings", systemImage: "gear") {
                   SettingsView()
                }
                Tab("Import", systemImage: "plus.app") {
                   NotionImportPageView()
                }
                
            }.tabBarMinimizeBehavior(.never)
                .background(Color.clear)
        }
    }
}

#Preview {
    RootTabs()
}
