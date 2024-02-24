import SwiftUI

struct WelcomeView: View {
    @ObservedObject private(set) var viewModel: WelcomeViewModel

    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.title)
            Text(viewModel.message)
            Button(action: viewModel.next, label: { Text("Next") })
            Spacer()
        }
    }
}
