import SwiftUI
import VisionKit

struct ScannerView: UIViewControllerRepresentable {
    typealias Completion = (Result<(front: UIImage, back: UIImage), ScannerCoordinator.ScannerError>) -> Void

    let completion: Completion

    func makeCoordinator() -> ScannerCoordinator {
        ScannerCoordinator(completion: completion)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        controller.view.backgroundColor = .clear
        DispatchQueue.main.async {
            context.coordinator.start(on: controller)
        }
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
