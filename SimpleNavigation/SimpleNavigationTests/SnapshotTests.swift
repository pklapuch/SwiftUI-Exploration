import SwiftUI
import XCTest
@testable import SimpleNavigation

final class SnapshotTests: XCTestCase {
    func test_snapshot_root() throws {
        let state = LoginScreenState(path: [], qrCode: "")
        let viewModel = LandingScreenViewModel(state: state)
        let loginScreen = LoginScreen(viewModel: viewModel)

        try snapshot(windowedView: loginScreen, name: "LoginScreen-Root")
    }

    func test_snapshot_enterPasword() throws {
        let state = LoginScreenState(path: [.enterPassword], qrCode: "")
        let viewModel = LandingScreenViewModel(state: state)
        let loginScreen = LoginScreen(viewModel: viewModel)

        try snapshot(windowedView: loginScreen, name: "LoginScreen-EnterPassword")
    }

    func test_snapshot_scanQrCode() throws {
        let state = LoginScreenState(path: [.scanQrCode], qrCode: "")
        let viewModel = LandingScreenViewModel(state: state)
        let loginScreen = LoginScreen(viewModel: viewModel)

        try snapshot(windowedView: loginScreen, name: "LoginScreen-ScanQrCode")
    }
}

extension XCTestCase {
    func snapshot(windowedView view: some View, name: String) throws {
        let image = view.asWindowedImage()
        let documentsURL = getDocumentsURL()
        let snapshotURL = documentsURL.appendingPathComponent("\(name).png", conformingTo: .fileURL)
        let snapshotData = try XCTUnwrap(image.pngData())
        try snapshotData.write(to: snapshotURL)

        print("snapshot stored at: \(snapshotURL.absoluteString)")
    }

    func getDocumentsURL() -> URL {
        FileManager
            .default.urls(for: .documentDirectory, in: .userDomainMask)
            .first!
    }
}

extension View {
    func asWindowedImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        let bounds = UIScreen.main.bounds
        
        let window = UIWindow(frame: bounds)
        window.rootViewController = controller
        window.makeKeyAndVisible()

        view?.bounds = bounds
        view?.backgroundColor = .clear

        return controller.view.asImage()
    }
}

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
