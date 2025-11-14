//
//  EventInsertionTests.swift
//  NetPriorityAITests
//
//  Verifies that an Event is inserted into SwiftData using an in-memory container.
//

import SwiftData
import Testing

@testable import NetPriorityAI

struct EventInsertionTests {

    //    Why an in-memory store?
    //
    //    - Isolated: Tests don’t touch your real on-disk data.
    //    - Fast: No file I/O; perfect for unit tests.
    //        - Deterministic: Each test starts clean; no leftover state to flake tests.
    //    - Zero cleanup: Process memory vanishes after the test.
    @MainActor
    @Test
    func insertEventInMemory() throws {
        // Create an in-memory SwiftData container for isolated testing
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(
            for: Event.self,
            configurations: config
        )
        let context = ModelContext(container)

        // Use the same view model path as the app
        let viewModel = AddEventViewModel()
        viewModel.modelContext = context

        // Given an Event
        let event = Event(
            eventName: "Test Event",
            eventLocation: "Test Location",
            goal: "Networking",
            eventDescription: "Meet new people and learn"
        )

        // When we insert via the view model
        viewModel.addEvent(event: event)

        // Then it should be persisted in the in-memory store
        let results = try context.fetch(FetchDescriptor<Event>())
        #expect(results.count == 1)

        if let saved = results.first {
            #expect(saved.eventName == "Test Event")
            #expect(saved.eventLocation == "Test Location")
            #expect(saved.goal == "Networking")
            #expect(saved.eventDescription == "Meet new people and learn")
        } else {
            Issue.record("No Event found after insertion")
        }
    }
}
