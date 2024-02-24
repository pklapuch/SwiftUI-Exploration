import XCTest
import SwiftUI
@testable import RouterNavigation

final class RouterNavigationTests: XCTestCase {
    func test_explanation_inIsolation() throws {
        let viewModel = ExplanationViewModel(onNext: {}, onRequestCamera: {})
        let view = ExplanationView(viewModel: viewModel)

        try snapshot(windowedView: view, name: "Explanation_isolatedState")
    }

    func test_explanation_inApplicationFlow() throws {
        let routerState = RouterViewModel.State(navigationPath: [.welcome, .explanation])
        container.router = RouterViewModel(state: routerState)

        let app = RouterNavigationApp()
        try snapshot(windowedView: app.contentView, name: "Explanation_inAppState")
    }

    func test_dashboard_inIsolation() throws {
        let viewModel = DashboardViewModel(onShowPrivacyPolicy: {}, onLogout: {})
        let view = DashboardView(viewModel: viewModel)

        try snapshot(windowedView: view, name: "Dashbaord_isolatedState")
    }

    func test_dashboard_inApplicationFlow() throws {
        let routerState = RouterViewModel.State(navigationPath: [.welcome, .login, .dashboard])
        container.router = RouterViewModel(state: routerState)

        let app = RouterNavigationApp()
        try snapshot(windowedView: app.contentView, name: "Dashbaord_inAppState")
    }

    func test_privacyPolicy_inApplicationFlow() throws {
        let routerState = RouterViewModel.State(
            navigationPath: [.welcome, .login, .dashboard],
            presentingSheet: .privacyPolicy
        )
        container.router = RouterViewModel(state: routerState)
        UIView.setAnimationsEnabled(false)

        let app = RouterNavigationApp()
        try snapshot(windowedView: app.contentView, name: "PrivacyPolicy_inAppState")
    }
}

private extension XCTestCase {
    func wait(timeInterval: TimeInterval = 1.0) {
        let exp = expectation(description: "wait")
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval, execute: {
            exp.fulfill()
        })
        wait(for: [exp], timeout: timeInterval + 0.05)
    }
}
