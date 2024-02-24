import Foundation

/// Fake container to have some shared state without too much over-enginerring in prootype app.
final class FakeContainer {
    var router: RouterViewModel
    var viewFactory: ViewFactory

    var isLoggedIn = false
    var hasCompletedOnboarding = false

    init() {
        router = RouterViewModel()
        viewFactory = DefaultViewFactory(router: router)
    }
}

var container = FakeContainer()
