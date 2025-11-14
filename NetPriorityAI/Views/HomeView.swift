//
//  HomeView.swift
//  NetPriorityAI
//
//  Created by Lung Hao Tung on 9/13/25.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Event]
    @StateObject private var viewModel = HomeViewModel()
    @State private var showingAddEvent = false

    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 160), spacing: 16)
    ]

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    //TODO: Need real data
                    AllCardsViewButton(title: "All Cards", action: {}, count: 10).padding(.all)
                    Divider().padding(.horizontal)
                    
                    LazyVGrid(columns: columns, spacing: 16) {

                        
                        ForEach(items) { item in
                            NavigationLink {
                                EventView(event: item)
                            } label: {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(item.eventName)
                                        .font(.headline)
                                        .foregroundStyle(.primary)
                                        .lineLimit(2)
                                        .multilineTextAlignment(.leading)
                                    if let goal = item.goal, !goal.isEmpty {
                                        Text(goal)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                            .lineLimit(2)
                                    }
                                    if let location = item.eventLocation,
                                        !location.isEmpty
                                    {
                                        HStack(spacing: 6) {
                                            Image(
                                                systemName: "mappin.and.ellipse"
                                            )
                                            .imageScale(.small)
                                            .foregroundStyle(.secondary)
                                            Text(location)
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                                .lineLimit(1)
                                        }
                                    }
                                }
                                .padding(12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(.secondarySystemBackground))
                                )
                            }
                        }
                    }
                    .padding(16)
                }

                Button(
                    action: { showingAddEvent = true }
                ) {
                    Label("Add Event", systemImage: "plus", ).labelStyle(
                        .iconOnly
                    )
                    .padding(10)
                    
                }
                .font(.title)
                .buttonStyle(.glassProminent)
                .padding(.trailing, 30)
                .sheet(isPresented: $showingAddEvent) {
                    AddEventView()
                }
            }

            .navigationTitle("Events")
            .onAppear {
                viewModel.modelContext = modelContext
            }
        }
    }
}

@MainActor
extension HomeView {
    fileprivate static var previewContainer: ModelContainer = {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(
            for: Event.self,
            configurations: config
        )
        let context = ModelContext(container)

        let samples: [Event] = [
            Event(
                eventName: "WWDC Meetup",
                eventLocation: "San Jose",
                goal: "Networking",
                eventDescription: "Meet iOS devs"
            ),
            Event(
                eventName: "Design Review",
                eventLocation: "Remote",
                goal: "Feedback",
                eventDescription: "UI polish session"
            ),
            Event(
                eventName: "Launch Party",
                eventLocation: "NYC",
                goal: nil,
                eventDescription: "Ship it!"
            ),
        ]
        samples.forEach { context.insert($0) }
        try? context.save()
        return container
    }()
}

#Preview("Home – Seeded") {
    HomeView()
        .modelContainer(HomeView.previewContainer)
}
