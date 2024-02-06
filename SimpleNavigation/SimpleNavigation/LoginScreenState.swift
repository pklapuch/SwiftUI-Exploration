import Foundation

struct LoginScreenState: Equatable {
    var path: [LandingPageRoute] = []
    var isLoggingIn: Bool = false
    var qrCode: String = ""

    // Example - App starts showing `root` screen
    static var initial: LoginScreenState {
        LoginScreenState(path: [], isLoggingIn: false, qrCode: "")
    }

    // Example - App starts showing `enterPassword screen (pushed onto stack) (so `root` > `enterPassword`)
    static var enterPassword: LoginScreenState {
        LoginScreenState(path: [.enterPassword], isLoggingIn: false, qrCode: "")
    }
}
