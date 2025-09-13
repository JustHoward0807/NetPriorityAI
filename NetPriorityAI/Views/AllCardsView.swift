//
//  AllCardsView.swift
//  NetPriorityAI
//
//  Created by Lung Hao Tung on 9/13/25.
//

import SwiftUI

struct AllCardsView: View {
    @StateObject private var viewModel = AllCardsViewModel()
    
    var body: some View {
        NavigationView {
            Text("All cards")
                .navigationTitle("All Cards")
        }
    }
}