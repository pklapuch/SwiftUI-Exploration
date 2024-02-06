import SwiftUI

struct ScanQRCodeLoginScreen: View {
    @ObservedObject var viewModel: LandingScreenViewModel

    var body: some View {
        VStack {
            Text("QR Code Scanner View")
        }
        .padding()
    }
}
