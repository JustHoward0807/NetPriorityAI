//
//  SettingsView.swift
//  NetPriorityAI
//
//  Created by Lung Hao Tung on 9/13/25.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            Text("Settings")
                .navigationTitle("Settings")
        }
    }
}