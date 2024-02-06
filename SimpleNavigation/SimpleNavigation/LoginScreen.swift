import SwiftUI

struct LoginScreen: View {
    @ObservedObject var viewModel: LandingScreenViewModel

    var body: some View {
        NavigationStack(path: $viewModel.state.path, root: {
            LandingPageView(viewModel: viewModel)
                .navigationDestination(for: LandingPageRoute.self, destination: { route in
                    switch route {
                    case .enterPassword:
                        OneTimePasswordLoginScreen(
                            onCompleted: viewModel.pop,
                            qrCode: $viewModel.state.qrCode, 
                            isLoggingIn: viewModel.state.isLoggingIn
                        )
                        .onAppear(perform: {
                            viewModel.didShowEnterPassword()
                        })
                    case .scanQrCode:
                        ScanQRCodeLoginScreen(viewModel: viewModel)
                            .onAppear(perform: {
                                viewModel.didShowScanQrCode()
                            })
                    }
                })
        })
        .padding()
        .onChange(of: viewModel.state.path) { oldValue, newValue in
            if !oldValue.isEmpty && newValue.isEmpty {
                viewModel.didPopToMain()
            }
        }
    }
}

#Preview {
    LoginScreen(viewModel: LandingScreenViewModel(state: .initial))
}
