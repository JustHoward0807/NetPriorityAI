//
//  Item.swift
//  NetPriorityAI
//
//  Created by Howard Private on 9/8/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
