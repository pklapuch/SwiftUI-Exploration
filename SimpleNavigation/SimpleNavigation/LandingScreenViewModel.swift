import SwiftUI

final class LandingScreenViewModel: ObservableObject {
    @Published var state: LoginScreenState

    init(state: LoginScreenState) {
        self.state = state
    }

    func navigate(route: LandingPageRoute)  {
        state.path.append(route)
    }

    func pop()  {
        state.path.removeLast()
    }

    func didShowScanQrCode() {
        print("did show scan qr code")
    }

    func didShowEnterPassword() {
        print("did show enter password")
    }

    func didPopToMain() {
        print("did pop to main")
    }
}
