import Foundation

@frozen
enum LoginAction: Equatable {
    case loginButtonTapped
    case loginSucceeded
    case loginFailed
}
