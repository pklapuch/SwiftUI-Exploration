import XCTest
import SwiftUI
@testable import RouterNavigation

final class RouterNavigationTests: XCTestCase {
    func test_dashboard_inIsolation() throws {
        let viewModel = DashboardViewModel(onShowPrivacyPolicy: {}, onLogout: {})
        let view = DashboardView(viewModel: viewModel)

        try snapshot(windowedView: view, name: "Dashbaord")
    }

    func test_dashboard_inApplicationFlow() throws {
        let app = RouterNavigationApp()

        let viewModel = DashboardViewModel(onShowPrivacyPolicy: {}, onLogout: {})
        let view = DashboardView(viewModel: viewModel)

        try snapshot(windowedView: view, name: "Dashbaord")
    }
}

