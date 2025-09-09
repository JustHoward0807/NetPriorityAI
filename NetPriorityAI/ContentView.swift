import SwiftUI

struct ContentView: View {
    @State private var showScanner = false
    @State private var frontImage: UIImage?
    @State private var backImage: UIImage?
    @State private var alertMessage: String?

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                if let frontImage = frontImage, let backImage = backImage {
                    VStack {
                        Text("Front")
                        Image(uiImage: frontImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 150)
                        Text("Back")
                        Image(uiImage: backImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 150)
                    }
                } else {
                    Text("No business card scanned yet")
                        .foregroundStyle(.secondary)
                }

                Button("Scan Business Card") {
                    showScanner = true
                }
                .padding()
            }
            .navigationTitle("Business Card Scanner")
        }
        .sheet(isPresented: $showScanner) {
            ScannerView { result in
                switch result {
                case .success(let images):
                    frontImage = images.front
                    backImage = images.back
                case .failure(let error):
                    alertMessage = message(for: error)
                }
                showScanner = false
            }
        }
        .alert(item: $alertMessage) { message in
            Alert(title: Text("Scanner Error"), message: Text(message), dismissButton: .default(Text("OK")))
        }
    }

    private func message(for error: ScannerCoordinator.ScannerError) -> String {
        switch error {
        case .unavailable:
            return "VisionKit scanner is not available on this device."
        case .cancelled:
            return "Scanning was cancelled."
        case .failed:
            return "Failed to capture image."
        case .underlying(let err):
            return err.localizedDescription
        }
    }
}

extension String: Identifiable {
    public var id: String { self }
}

#Preview {
    ContentView()
}
