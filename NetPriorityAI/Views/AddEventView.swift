import MapKit
import PhotosUI
import SwiftUI
import TipKit

struct AddEventView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = AddEventViewModel()
    @State private var eventName = ""
    @State private var eventLocation = ""
    @State private var eventGoal = ""
    @State private var eventDescription = ""
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var selectedIcon: String? = nil
    private let eventSymbols: [String] = [
        "calendar", "party.popper", "mappin.and.ellipse", "figure.run", "tshirt", "music.note", "book", "camera", "leaf", "gift", "sportscourt", "cart", "heart", "star", "briefcase"
    ]
    private let goalTip = GeneralPopOverTip(
        title: Text("Purpose"),
        message: Text(
            "Giving goal for this event helps AI better analyze result."
        )
    )

    //TODO: Map feature
    //    private let myHome = CLLocationCoordinate2D(
    //        latitude: 40.7493963,
    //        longitude: -111.899047
    //    )

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack(spacing: 8) {
                        if let selectedIcon {
                            Image(systemName: selectedIcon)
                                .foregroundStyle(.secondary)
                        } else {
                            Image(systemName: "app.dashed")
                                .foregroundStyle(.tertiary)
                        }

                        TextField("Event Name", text: $eventName)

                        Menu {
                            ForEach(eventSymbols, id: \.self) { symbol in
                                Button(action: { selectedIcon = symbol }) {
                                    Label(symbol.replacingOccurrences(of: ".", with: " "), systemImage: symbol)
                                }
                            }

                            if selectedIcon != nil {
                                Divider()
                                Button(role: .destructive) {
                                    selectedIcon = nil
                                } label: {
                                    Label("Clear Icon", systemImage: "xmark.circle")
                                }
                            }
                        } label: {
                            Image(systemName: "square.grid.2x2")
                                .imageScale(.medium)
                                .foregroundStyle(.secondary)
                        }
                        .buttonStyle(.plain)
                    }
                    
//                    PhotosPicker(selection: $selectedPhoto, matching: .images) {
//                        if let data = selectedImageData,
//                            let uiImage = UIImage(data: data)
//                        {
//                            Image(uiImage: uiImage)
//                                .resizable()
//                                .scaledToFill()
//                                .frame(height: 200)
//                                .frame(maxWidth: .infinity)
//                                .clipped()
//                        } else {
//                            ZStack {
//                                Rectangle()
//                                    .fill(Color.gray.opacity(0.3))
//                                    .frame(height: 200)
//                                Image(systemName: "photo")
//                                    .font(.largeTitle)
//                                    .foregroundColor(.gray)
//                            }
//                        }
//                    }
//                    .clipShape(RoundedRectangle(cornerRadius: 12))
//                    .listRowBackground(Color.clear)
//                    .listRowInsets(EdgeInsets())
//                    .onChange(of: selectedPhoto, initial: false) {
//                        oldValue,
//                        newValue in
//                        if let newValue {
//                            Task {
//                                if let data =
//                                    try? await newValue.loadTransferable(
//                                        type: Data.self
//                                    )
//                                {
//                                    selectedImageData = data
//                                }
//                            }
//                        }
//                    }
                }

                Section {
                    
                    TextField("Location", text: $eventLocation)
                    TextField(
                        "What's ur goal for this event?",
                        text: $eventGoal
                    )
                    .padding(.trailing, 28)
                    .popoverTip(goalTip, arrowEdge: .top)
                    // .overlay(alignment: .trailing) {
                    //     Button(
                    //         action: {
                    //             GeneralPopOverTip.buttonPressed = true
                    //         }) {
                    //             Image(systemName: "lightbulb")
                    //                 .imageScale(.medium)
                    //                 .foregroundStyle(.secondary)
                    //         }
                    //         .buttonStyle(.plain)
                    //         .popoverTip(goalTip, arrowEdge: .top)

                    // }
                    TextField(
                        "Description",
                        text: $eventDescription,
                        axis: .vertical
                    )
                    .lineLimit(5...8)
                }

                //                Section {
                //                    Map {
                //                        Annotation(
                //                            "San Francisco City Hall",
                //                            coordinate: myHome
                //                        ) {
                //                            ZStack {
                //                                RoundedRectangle(cornerRadius: 5)
                //                                    .fill(Color.yellow)
                //                                Text("🛝")
                //                                    .padding(5)
                //                            }
                //                        }
                //
                //                    }
                //
                //                    .frame(height: 200)
                //                    .frame(maxWidth: .infinity)
                //                    .listRowBackground(Color.clear)
                //                    .listRowInsets(EdgeInsets())
                //                }
            }
            .navigationTitle("New Event")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        let event: Event = Event(
                            eventName: eventName,
                            eventLocation: eventLocation,
                            goal: eventGoal,
                            eventDescription: eventDescription,
                            iconSymbol: selectedIcon
                        )
                        viewModel.addEvent(event: event)
                        dismiss()
                    }.disabled(eventName.isEmpty)
                }

            }
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.modelContext = modelContext
        }
    }
        

}

#Preview {
    AddEventView()
}

