//
//  HomeViewModel.swift
//  NetPriorityAI
//
//  Created by Lung Hao Tung on 9/13/25.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    var modelContext: ModelContext?
    
    init() {
        // Empty init - modelContext will be set from the view
    }
    
    func addItem() {
        guard let modelContext = modelContext else { return }
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }
    
    func deleteItems(items: [Item], offsets: IndexSet) {
        guard let modelContext = modelContext else { return }
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}
