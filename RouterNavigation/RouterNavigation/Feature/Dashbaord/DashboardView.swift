import SwiftUI

struct DashboardView: View {
    @ObservedObject private(set) var viewModel: DashboardViewModel

    var body: some View {
        VStack {
            Spacer()
            Button(action: viewModel.showPrivacyPolicy, label: { Text("Show Privacy Policy") })
            Spacer()
            Button(action: logout, label: { Text("Logout") })
            Spacer()
        }
        .navigationBarBackButtonHidden()
    }

    private func logout() {
        Task {
            await viewModel.logout()
        }
    }
}
