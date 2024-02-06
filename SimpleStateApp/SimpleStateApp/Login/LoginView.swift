import SwiftUI

struct LoginView: View {
    @ObservedObject var store: Store<LoginState, LoginAction>

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)

            Button(
                action: { store.perform(action: .loginButtonTapped) },
                label: { Text("Login") }
            ).padding()

            Text(store.state.isLoading ? "Loading" : "Loaded")
            if let result = store.state.loginResult {
                Text("Login Result: \(result)")
            }
        }
        .padding()
    }
}

#Preview {
    LoginView(
        store: LoginStore(state: LoginState(), reducer: LoginReducer.reduce)
    )
}
