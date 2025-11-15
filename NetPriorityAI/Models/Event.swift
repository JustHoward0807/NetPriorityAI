//
//  Event.swift
//  NetPriorityAI
//
//  Created by Lung Hao Tung on 9/14/25.
//

import Foundation
import SwiftData

@Model
final class Event {
    var eventName: String
    var eventLocation: String?
    var goal: String?
    var eventDescription: String?
    var iconSymbol: String?
    // TODO: Image function for later
    // var image: Data?

    init(
        eventName: String,
        eventLocation: String?,
        goal: String?,
        eventDescription: String?,
        iconSymbol: String? = nil
    ) {
        self.eventName = eventName
        self.eventLocation = eventLocation
        self.goal = goal
        self.eventDescription = eventDescription
        self.iconSymbol = iconSymbol
    }
}
