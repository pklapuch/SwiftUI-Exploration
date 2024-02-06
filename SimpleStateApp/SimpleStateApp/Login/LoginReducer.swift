import Foundation

enum LoginReducer {
    static func reduce(
        state: inout LoginState,
        action: LoginAction
    ) -> Effect<LoginAction>? {
        switch action {
        case .loginButtonTapped:
            state.isLoading = true
            return simulateLoginEffect()
        case .loginSucceeded:
            state.isLoading = false
            state.loginResult = "success"
            return nil
        case .loginFailed:
            return nil
        }
    }

    private static func simulateLoginEffect() -> Effect<LoginAction> {
        return { effectCompletion in
            effectCompletion(.loginSucceeded)
        }
    }
}
