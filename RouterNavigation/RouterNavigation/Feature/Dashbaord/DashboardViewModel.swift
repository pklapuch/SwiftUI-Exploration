import Foundation

final class DashboardViewModel: ObservableObject {
    let onLogout: () -> Void

    init(onLogout: @escaping () -> Void) {
        self.onLogout = onLogout
    }

    func logout() async {
        onLogout()
    }
}
