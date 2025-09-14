import SwiftUI
import PhotosUI

struct AddEventView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var eventName = ""
    @State private var eventLocation = ""
    @State private var eventGoal = ""
    @State private var eventDescription = ""

    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    PhotosPicker(selection: $selectedPhoto, matching: .images) {
                        if let data = selectedImageData, let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200)
                                .frame(maxWidth: .infinity)
                                .clipped()
                        } else {
                            ZStack {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 200)
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .onChange(of: selectedPhoto) { newValue in
                        if let newValue {
                            Task {
                                if let data = try? await newValue.loadTransferable(type: Data.self) {
                                    selectedImageData = data
                                }
                            }
                        }
                    }

                    Group {
                        TextField("Event Name", text: $eventName)
                            .textFieldStyle(.roundedBorder)
                        TextField("Event Location", text: $eventLocation)
                            .textFieldStyle(.roundedBorder)
                        TextField("Event Goal", text: $eventGoal)
                            .textFieldStyle(.roundedBorder)
                        TextField("Description", text: $eventDescription)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("New Event")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") { dismiss() }
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    AddEventView()
}
