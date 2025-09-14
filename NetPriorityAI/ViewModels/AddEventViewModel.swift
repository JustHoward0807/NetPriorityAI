//
//  AddEventViewModel.swift
//  NetPriorityAI
//
//  Created by Lung Hao Tung on 9/14/25.
//

import Foundation
import SwiftData

@MainActor
class AddEventViewModel: ObservableObject {
    var modelContext: ModelContext?
    
    func AddEvent(event: Event) {
        guard let modelContext = modelContext else {return}
        //TODO: Insert event into database
    }
}
