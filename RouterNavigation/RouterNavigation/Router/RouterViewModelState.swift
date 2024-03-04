import Foundation

/// State can be updated in two ways:
/// - By `ViewModel action`: i.e. viewModel calls `push(route)`
/// - By `SwiftUI binding`: ..e user swipes modal away or taps on `back buton`
struct RouterViewModelState {
    var navigationPath: [Route] = []
    var presentingSheet: Route? = nil
    var presentingFullScreen: Route? = nil
    var presentingModal: Route? = nil
    var presentingAlert: Bool = false
}

// MARK: - Convenience

extension RouterViewModelState {
    static var inital: RouterViewModelState { RouterViewModelState(navigationPath: []) }
}
