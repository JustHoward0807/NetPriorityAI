import SwiftUI
import VisionKit

final class ScannerCoordinator: NSObject, VNDocumentCameraViewControllerDelegate {
    enum Phase { case front, back }
    enum ScannerError: Error {
        case unavailable
        case cancelled
        case failed
        case underlying(Error)
    }

    private var phase: Phase = .front
    private var frontImage: UIImage?
    private let completion: (Result<(front: UIImage, back: UIImage), ScannerError>) -> Void

    init(completion: @escaping (Result<(front: UIImage, back: UIImage), ScannerError>) -> Void) {
        self.completion = completion
    }

    func start(on presenter: UIViewController) {
        guard VNDocumentCameraViewController.isSupported else {
            completion(.failure(.unavailable))
            return
        }
        presentScanner(on: presenter)
    }

    private func presentScanner(on presenter: UIViewController) {
        let scanner = VNDocumentCameraViewController()
        scanner.delegate = self
        presenter.present(scanner, animated: true)
    }

    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        guard scan.pageCount > 0 else {
            controller.dismiss(animated: true) { [weak self] in
                self?.completion(.failure(.failed))
            }
            return
        }
        let image = scan.imageOfPage(at: 0)
        switch phase {
        case .front:
            frontImage = image
            phase = .back
            controller.dismiss(animated: true) { [weak self] in
                guard let self = self, let presenter = controller.presentingViewController else { return }
                let alert = UIAlertController(title: "Scan Back", message: "Flip the business card and scan the back side.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Continue", style: .default) { _ in
                    self.presentScanner(on: presenter)
                })
                presenter.present(alert, animated: true)
            }
        case .back:
            controller.dismiss(animated: true) { [weak self] in
                guard let self = self, let front = self.frontImage else {
                    self?.completion(.failure(.failed))
                    return
                }
                self.completion(.success((front: front, back: image)))
            }
        }
    }

    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true) { [weak self] in
            self?.completion(.failure(.cancelled))
        }
    }

    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        controller.dismiss(animated: true) { [weak self] in
            self?.completion(.failure(.underlying(error)))
        }
    }
}
