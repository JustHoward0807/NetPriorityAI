import SwiftUI
import VisionKit

enum ScanError: Error {
    case cancelled
    case failed(Error)
    case notSupported
}

struct DocumentScannerView: UIViewControllerRepresentable {
    typealias Completion = (Result<UIImage, ScanError>) -> Void
    var completion: Completion

    func makeCoordinator() -> Coordinator {
        Coordinator(completion: completion)
    }

    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let controller = VNDocumentCameraViewController()
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {}

    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        let completion: Completion

        init(completion: @escaping Completion) {
            self.completion = completion
        }

        func documentCamera(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            guard scan.pageCount > 0 else {
                let err = NSError(domain: "Scanner", code: -1, userInfo: [NSLocalizedDescriptionKey: "No page captured"])
                completion(.failure(.failed(err)))
                controller.dismiss(animated: true)
                return
            }
            let image = scan.imageOfPage(at: 0)
            completion(.success(image))
            controller.dismiss(animated: true)
        }

        func documentCameraDidCancel(_ controller: VNDocumentCameraViewController) {
            completion(.failure(.cancelled))
            controller.dismiss(animated: true)
        }

        func documentCamera(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            completion(.failure(.failed(error)))
            controller.dismiss(animated: true)
        }
    }
}

struct BusinessCardScannerButton: View {
    var completion: (Result<(front: UIImage, back: UIImage), ScanError>) -> Void

    @State private var showScanner = false
    @State private var showInstruction = false
    @State private var scanningBack = false
    @State private var frontImage: UIImage?
    @State private var showUnavailableAlert = false

    var body: some View {
        Button("Scan Business Card") {
            guard VNDocumentCameraViewController.isSupported else {
                showUnavailableAlert = true
                completion(.failure(.notSupported))
                return
            }
            scanningBack = false
            showScanner = true
        }
        .sheet(isPresented: $showScanner) {
            DocumentScannerView { result in
                switch result {
                case .success(let image):
                    if !scanningBack {
                        frontImage = image
                        showScanner = false
                        showInstruction = true
                    } else if let front = frontImage {
                        completion(.success((front: front, back: image)))
                        showScanner = false
                    }
                case .failure(let error):
                    completion(.failure(error))
                    showScanner = false
                }
            }
        }
        .sheet(isPresented: $showInstruction) {
            VStack(spacing: 20) {
                Text("Flip the card and scan the back.")
                Button("Scan Back") {
                    showInstruction = false
                    scanningBack = true
                    showScanner = true
                }
                Button("Cancel") {
                    showInstruction = false
                    completion(.failure(.cancelled))
                }
            }
            .padding()
        }
        .alert("Scanner Unavailable", isPresented: $showUnavailableAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("This device does not support document scanning.")
        }
    }
}

