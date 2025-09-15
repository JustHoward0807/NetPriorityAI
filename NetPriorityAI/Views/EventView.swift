import SwiftUI

struct EventView: View {
    @Environment(\.dismiss) private var dismiss
    let event: Event
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(eventDisplayText)
                        .font(.body)
                        .padding()
                }
            }
            .navigationTitle("Event Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        
    }
    
    private var eventDisplayText: String {
        var text = ""
        
        text += "Event Name: \(event.eventName)\n\n"
        
        if let location = event.eventLocation, !location.isEmpty {
            text += "Location: \(location)\n\n"
        }
        
        if let goal = event.goal, !goal.isEmpty {
            text += "Goal: \(goal)\n\n"
        }
        
        if let description = event.eventDescription, !description.isEmpty {
            text += "Description: \(description)\n\n"
        }
        
        return text
    }
}

#Preview {
    let sampleEvent = Event(
        eventName: "Sample Event",
        eventLocation: "Sample Location",
        goal: "Sample Goal",
        eventDescription: "This is a sample event description for preview purposes."
    )
    return EventView(event: sampleEvent)
}
