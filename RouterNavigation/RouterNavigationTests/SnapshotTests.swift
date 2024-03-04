import XCTest
import SwiftUI
import SnapshotTesting
@testable import RouterNavigation

final class RouterNavigationTests: XCTestCase {
    let record = true

    func test_explanation_inIsolation() throws {
        let viewModel = ExplanationViewModel(onNext: {}, onRequestCamera: {})
        let view = ExplanationView(viewModel: viewModel)

        assertSnapshot(
            matching: UIHostingController.wrap(view: view),
            as: .image(on: .iPhoneX),
            record: record
        )
    }

    func test_explanation_inApplicationFlow() throws {
        let routerState = RouterViewModelState(navigationPath: [.welcome, .explanation])
        container.router = RouterViewModel(state: routerState)

        let app = RouterNavigationApp()
        assertSnapshot(
            matching: UIHostingController.wrap(view: app.contentView),
            as: .image(on: .iPhoneX),
            record: record
        )
    }

    func test_dashboard_inIsolation() throws {
        let viewModel = DashboardViewModel(onShowPrivacyPolicy: {}, onLogout: {})
        let view = DashboardView(viewModel: viewModel)

        assertSnapshot(
            matching: UIHostingController.wrap(view: view),
            as: .image(on: .iPhoneX),
            record: record
        )
    }

    func test_dashboard_inApplicationFlow() throws {
        let routerState = RouterViewModelState(navigationPath: [.welcome, .login, .dashboard])
        container.router = RouterViewModel(state: routerState)

        let app = RouterNavigationApp()
        assertSnapshot(
            matching: UIHostingController.wrap(view: app.contentView),
            as: .image(on: .iPhoneX),
            record: record
        )
    }

    func test_privacyPolicy_inApplicationFlow() throws {
        let viewFactory = container.viewFactory as! DefaultViewFactory
        let app = RouterNavigationApp()
        let vc = UIHostingController.wrap(view: app.contentView)

        viewFactory.welcomeViewModel!.next()
        wait(timeInterval: 1)

        Task { await viewFactory.expViewModel!.next() }
        wait(timeInterval: 1)

        viewFactory.resultViewModel!.next()
        wait(timeInterval: 1)

        Task { await viewFactory.loginViewModel!.login() }
        wait(timeInterval: 1)

        viewFactory.dashboardViewModel!.showPrivacyPolicy()
        wait(timeInterval: 1)

        assertSnapshot(
            of: vc,
            as: .windowedImage,
            record: record
        )
    }
}
