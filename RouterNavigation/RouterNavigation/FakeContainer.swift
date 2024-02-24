import Foundation

/// Fake container to have some shared state without too much over-enginerring in prootype app.
final class FakeContainer {
    var isLoggedIn = false
    var hasCompletedOnboarding = false
}

var container = FakeContainer()
