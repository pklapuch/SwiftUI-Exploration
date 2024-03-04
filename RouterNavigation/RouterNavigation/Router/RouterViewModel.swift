import SwiftUI

/// Router is responsible for `Navigation and Presentation` of views
final class RouterViewModel: ObservableObject {
    /// Analytics? Testing? etc - optional callback...
    var onDidShowRoute: ((Route) -> Void)?

    @Published private(set) var state: RouterViewModelState

    init(state: RouterViewModelState = .inital) {
        self.state = state
    }

    // MARK: - Navigation

    func replace(path: [Route]) {
        state.navigationPath = path
    }

    func push(route: Route) {
        state.navigationPath.append(route)
    }

    func pop() {
        state.navigationPath.removeLast()
    }

    func popToRoot() {
        state.navigationPath.removeAll()
    }

    // MARK: - Sheet Presentation

    func presentSheet(route: Route) {
        state.presentingSheet = route
    }

    func dismissSheet() {
        state.presentingSheet = nil
    }

    // MARK: - Fullscreen Presentation

    func presentFullscreen(route: Route) {
        state.presentingFullScreen = route
    }

    func dismissFullscreen() {
        state.presentingFullScreen = nil
    }

    // MARK: - Modal Presentation

    func presentModal(route: Route) {
        state.presentingModal = route
    }

    func dismissModal() {
        state.presentingModal = nil
    }

    // MARK: - Alert Presentation

    func presentAlert() {
        state.presentingAlert = true
    }

    func dismissAlert() {
        state.presentingAlert = false
    }

    // MARK: - Navigation Events

    func didShow(route: Route) {
        onDidShowRoute?(route)
    }
}

// MARK: - Bindings

extension RouterViewModel {
    var navigationPath: Binding<[Route]> {
        binding(keyPath: \.navigationPath)
    }

    var presentingSheet: Binding<Route?> {
        binding(keyPath: \.presentingSheet)
    }

    var presentingFullScreen: Binding<Route?> {
        binding(keyPath: \.presentingFullScreen)
    }

    var presentingModal: Binding<Route?> {
        binding(keyPath: \.presentingModal)
    }

    var presentingAlert: Binding<Bool> {
        binding(keyPath: \.presentingAlert)
    }

    func binding<T>(keyPath: WritableKeyPath<RouterViewModelState, T>) -> Binding<T> {
        Binding(
            get: { self.state[keyPath: keyPath] },
            set: { self.state[keyPath: keyPath] = $0 }
        )
    }
}
