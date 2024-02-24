import SwiftUI

/// Router is responsible for `Navigation and Presentation` of views
open class RouterViewModel: ObservableObject {
    @Published private(set) var state: State = .inital

    init() {}

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
}

// MARK: - Router State

extension RouterViewModel {
    struct State {
        var navigationPath: [Route] = []
        var presentingSheet: Route? = nil
        var presentingFullScreen: Route? = nil
        var presentingModal: Route? = nil
    }
}

// MARK: - Convenience

extension RouterViewModel.State {
    static var inital: RouterViewModel.State { RouterViewModel.State(navigationPath: []) }
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

    func binding<T>(keyPath: WritableKeyPath<State, T>) -> Binding<T> {
        Binding(
            get: { self.state[keyPath: keyPath] },
            set: { self.state[keyPath: keyPath] = $0 }
        )
    }
}
