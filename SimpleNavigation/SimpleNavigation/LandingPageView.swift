import SwiftUI

struct LandingPageView: View {
    @ObservedObject var viewModel: LandingScreenViewModel

    var body: some View {
        VStack {
            Text("Landing Page View")
            Spacer(minLength: 20)

            Button(
                action: { viewModel.navigate(route: .enterPassword) },
                label: { Text("Scan QR Code") }
            )
            .padding()

            Button(
                action: { viewModel.navigate(route: .scanQrCode) },
                label: { Text("Enter QR Code") }
            )
            .padding()

            Spacer()
        }
    }
}

#Preview {
    LandingPageView(viewModel: LandingScreenViewModel(state: .initial))
}
