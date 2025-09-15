//
//  NetPriorityAIApp.swift
//  NetPriorityAI
//
//  Created by Lung Hao Tung on 9/8/25.
//

import SwiftData
import SwiftUI
import TipKit

@main
struct NetPriorityAIApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            Event.self
        ])
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )

        do {
            return try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainView()
                .task {
                    do {
                        // Configure and load your tips at app launch.
                        #if DEBUG
                            try Tips.resetDatastore()
                        #endif

                        try Tips.configure()

                    } catch {
                        // Handle TipKit errors
                        print(
                            "Error initializing TipKit \(error.localizedDescription)"
                        )
                    }
                }
        }
        .modelContainer(sharedModelContainer)
    }

}
