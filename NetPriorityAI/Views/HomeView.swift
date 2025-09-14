//
//  HomeView.swift
//  NetPriorityAI
//
//  Created by Lung Hao Tung on 9/13/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @StateObject private var viewModel = HomeViewModel()
    @State private var showingAddEvent = false

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete { offsets in
                    viewModel.deleteItems(items: items, offsets: offsets)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        showingAddEvent = true
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .onAppear {
                viewModel.modelContext = modelContext
            }
        } detail: {
            Text("Select an item")
        }
        .fullScreenCover(isPresented: $showingAddEvent) {
            AddEventView()
        }
    }
}