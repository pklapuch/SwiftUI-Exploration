import SwiftUI

struct LoginView: View {
    @ObservedObject private(set) var viewModel: LoginViewModel

    var body: some View {
        VStack {
            Spacer()
            Button(action: login, label: { Text("Login") })
            Spacer()
        }
    }

    private func login() {
        Task {
            await viewModel.login()
        }
    }
}
