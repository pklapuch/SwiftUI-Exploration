import SwiftUI

@main
struct RouterNavigationApp: App {
    private let router: RouterViewModel
    private let viewFactory: ViewFactory

    init() {
        router = container.router
        viewFactory = container.viewFactory
    }

    var body: some Scene {
        WindowGroup {
            contentView
        }
    }

    /// `not private` so it can be accessed from test target (snapshot tests)
    var contentView: some View {
        RouterView(
            viewModel: router,
            rootContent: { makeInitialView() },
            contentFactory: viewFactory
        )
    }

    @ViewBuilder private func makeInitialView() -> some View {
        switch (container.isLoggedIn, container.hasCompletedOnboarding) {
        case (false, false):
            viewFactory.make(route: .welcome, mode: .navigation)
        case (false, _):
            viewFactory.make(route: .login, mode: .navigation)
        default:
            viewFactory.make(route: .dashboard, mode: .navigation)
        }
    }
}
