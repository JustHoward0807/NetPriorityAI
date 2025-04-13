//
//  LandingPage.swift
//  NetPriorityAI
//
//  Created by Howard Tung on 4/11/25.
//

import SwiftUI

struct LandingPageView: View {
    @State private var navigateToContent = false
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Button("Create Profile") {
                    navigateToContent = true
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .font(.system(size: 17, weight: .semibold, design: .rounded))
                .background(.appPrimaryAccent)
                .foregroundStyle(.white)
                .cornerRadius(15)
                .padding(.horizontal, 80)
                .padding(.bottom, 50)
            }.navigationDestination(isPresented: $navigateToContent) {
                BoardingPageView().navigationBarBackButtonHidden(true)
            }
            .background(.backgroundPrimary)
        }
    }
}

#Preview {
    LandingPageView()
}
