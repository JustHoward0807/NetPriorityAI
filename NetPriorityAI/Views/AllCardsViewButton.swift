//
//  AllCardsViewButton.swift
//  NetPriorityAI
//
//  Created by Howard Tung on 11/13/25.
//

import SwiftUI

struct AllCardsViewButton: View {
    let title: String
    let action: () -> Void
    let count: Int
    
    @GestureState private var isPressed = false

    var body: some View {
        
            Button(action: action) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "mail")
                        Spacer()
                        Text(String(count))
                            .font(.title)
                            .bold()
                    }
                    Text(title)
                        .font(.headline)
                }
                .padding(12)
                .frame( alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemBlue))
                )
                .foregroundStyle(.white)
                .scaleEffect(isPressed ? 0.97 : 1.0)
                .opacity(isPressed ? 0.95 : 1.0)
                .shadow(
                    color: isPressed ? Color.black.opacity(0.12) : Color.clear,
                    radius: isPressed ? 8 : 0,
                    x: 0,
                    y: isPressed ? 4 : 0
                )
                .animation(
                    .spring(
                        response: 0.25,
                        dampingFraction: 0.8,
                        blendDuration: 0.1
                    ),
                    value: isPressed
                )
            }
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .updating($isPressed) { _, state, _ in
                        state = true
                    }
            )
            .contentShape(RoundedRectangle(cornerRadius: 12))
        
    }
}


#Preview {
    AllCardsViewButton(title: "All Cards", action: {}, count: 10)
}

