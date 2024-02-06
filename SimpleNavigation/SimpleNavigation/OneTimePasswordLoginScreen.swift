import SwiftUI

struct OneTimePasswordLoginScreen: View {
    let onCompleted: () -> Void
    @Binding var qrCode: String
    let isLoggingIn: Bool

    var body: some View {
        VStack {
            Text("Password View")

            if isLoggingIn {
                Text("Login: In Progress")
            } else {
                Text("Login: Idle")
            }

            Button(
                action: { onCompleted() },
                label: { Text("Back") }
            )
        }
        .padding()
    }
}
