import Foundation

final class DashboardViewModel: ObservableObject {
    let onShowPrivacyPolicy: () -> Void
    let onLogout: () -> Void

    init(
        onShowPrivacyPolicy: @escaping () -> Void,
        onLogout: @escaping () -> Void
    ) {
        self.onShowPrivacyPolicy = onShowPrivacyPolicy
        self.onLogout = onLogout
    }

    func showPrivacyPolicy() {
        onShowPrivacyPolicy()
    }

    func logout() async {
        onLogout()
    }
}
