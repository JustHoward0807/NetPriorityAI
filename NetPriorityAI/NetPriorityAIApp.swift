//
//  NetPriorityAIApp.swift
//  NetPriorityAI
//
//  Created by Howard Tung on 4/11/25.
//

import SwiftUI

@main
struct NetPriorityAIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
