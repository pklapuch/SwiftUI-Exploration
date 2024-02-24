import SwiftUI

struct DashboardView: View {
    @ObservedObject private(set) var viewModel: DashboardViewModel

    var body: some View {
        VStack {
            Spacer()
            Button(action: logout, label: { Text("Logout") })
            Spacer()
        }
    }

    private func logout() {
        Task {
            await viewModel.logout()
        }
    }
}
