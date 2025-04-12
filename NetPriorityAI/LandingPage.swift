//
//  LandingPage.swift
//  NetPriorityAI
//
//  Created by Howard Tung on 4/11/25.
//

import SwiftUI

struct LandingPage: View {
    var body: some View {
        VStack {
            Spacer()
            
            Button("Create Profile") {
                // TODO: Function here
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .font(.system(size: 17, weight: .semibold, design: .rounded))
            .background(.appPrimaryAccent)
            .foregroundStyle(.white)
            .cornerRadius(15)
            .padding(.horizontal, 80)
            .padding(.bottom, 50)
        }
        .background(.backgroundPrimary)
    }
}

#Preview {
    LandingPage()
}
