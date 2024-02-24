import Foundation

final class PrivacyPolicyViewModel: ObservableObject {
    let onClose: () -> Void

    init(onClose: @escaping () -> Void) {
        self.onClose = onClose
    }

    func close() {
        onClose()
    }
}
