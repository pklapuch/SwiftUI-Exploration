import Foundation

typealias EffectCompletion<Action> = (Action?) -> Void
typealias Effect<Action> = (EffectCompletion<Action>) -> Void
typealias Reducer<State, Action> = (inout State, Action) -> Effect<Action>?

final class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State
    private let reducer: Reducer<State, Action>

    init(
        state: State,
        reducer: @escaping Reducer<State, Action>
    ) {
        self.state = state
        self.reducer = reducer
    }

    func perform(action: Action) {
        guard let effect = reducer(&state, action) else { return }

        effect {
            performEffect(action: $0)
        }
    }

    private func performEffect(action: Action?) {
        if let action {
            perform(action: action)
        }
    }
}
