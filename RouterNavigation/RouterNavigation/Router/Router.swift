import SwiftUI

/// Router is responsible for `Navigation and Presentation` of views
open class Router: ObservableObject {
    typealias MakeView = (Route, PresentationMode) -> AnyView

    @Published private(set) var state: State = .inital
    private let viewFactory: MakeView

    init(viewFactory: @escaping MakeView = { _, _ in AnyView(EmptyView()) }) {
        self.viewFactory = viewFactory
    }

    func view(for route: Route, mode: PresentationMode) -> AnyView {
        viewFactory(route, mode)
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
}

// MARK: - Bindings

extension Router {
    var navigationPath: Binding<[Route]> {
        binding(keyPath: \.navigationPath)
    }

    func binding<T>(keyPath: WritableKeyPath<State, T>) -> Binding<T> {
        Binding(
            get: { self.state[keyPath: keyPath] },
            set: { self.state[keyPath: keyPath] = $0 }
        )
    }
}

// MARK: - Router State

extension Router {
    struct State {
        var navigationPath: [Route] = []
    }
}

extension Router.State {
    static var inital: Router.State { Router.State(navigationPath: []) }
}
