import SwiftUI

@main
struct SimpleNavigationApp: App {
    var body: some Scene {
        WindowGroup {
            LoginScreen(viewModel: LandingScreenViewModel(state: .enterPassword))
        }
    }
}
