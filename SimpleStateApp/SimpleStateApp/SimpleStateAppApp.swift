import SwiftUI

@main
struct SimpleStateAppApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(store: LoginStore(state: LoginState(), reducer: LoginReducer.reduce))
        }
    }
}
