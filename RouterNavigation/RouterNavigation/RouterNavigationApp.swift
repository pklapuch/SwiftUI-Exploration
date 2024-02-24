import SwiftUI

@main
struct RouterNavigationApp: App {
    private let router: RouterViewModel
    private let viewFactory: DefaultViewFactory

    init() {
        router = RouterViewModel()
        viewFactory = DefaultViewFactory(router: router)
    }

    var body: some Scene {
        WindowGroup {
            RouterView(
                viewModel: router,
                rootContent: { makeInitialView() },
                contentFactory: viewFactory
            )
        }
    }

    @ViewBuilder private func makeInitialView() -> some View {
        switch (container.isLoggedIn, container.hasCompletedOnboarding) {
        case (false, false):
            viewFactory.makeWelcomeView()
        case (false, _):
            viewFactory.makeLoginView()
        default:
            viewFactory.makeDashboardView()
        }
    }
}
