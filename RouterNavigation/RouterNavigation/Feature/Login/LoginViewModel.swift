import Foundation

final class LoginViewModel: ObservableObject {
    let onDidLogin: () -> Void

    init(onDidLogin: @escaping () -> Void) {
        self.onDidLogin = onDidLogin
    }

    func login() async {
        // simualte login...

        onDidLogin()
    }
}
