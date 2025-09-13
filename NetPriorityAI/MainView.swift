//
//  MainView.swift
//  NetPriorityAI
//
//  Created by Lung Hao Tung on 9/8/25.
//

import SwiftUI
import SwiftData

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            AllCardsView()
                .tabItem {
                    Label("All cards", systemImage: "square.stack")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    MainView()
        .modelContainer(for: Item.self, inMemory: true)
}
