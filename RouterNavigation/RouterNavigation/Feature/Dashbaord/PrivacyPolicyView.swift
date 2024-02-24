import SwiftUI

struct PrivacyPolicyView: View {
    @ObservedObject private(set) var viewModel: PrivacyPolicyViewModel

    var body: some View {
        VStack {
            Spacer()
            Button(action: viewModel.close, label: { Text("Close") })
            Spacer()
            Text("Some text bla bla bla")
            Spacer()
        }
    }
}
