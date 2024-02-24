import Foundation

final class WelcomeViewModel: ObservableObject {
    let showNextPage: () -> Void

    @Published private(set) var title: String = "Welcome View"
    @Published private(set) var message: String = "Welcome View Message"

    init(showNextPage: @escaping () -> Void) {
        self.showNextPage = showNextPage
    }

    func next() {
        showNextPage()
    }
}
