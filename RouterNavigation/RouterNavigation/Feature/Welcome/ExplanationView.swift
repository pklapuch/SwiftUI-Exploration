import SwiftUI

struct ExplanationView: View {
    @ObservedObject var viewModel: ExplanationViewModel

    init(viewModel: ExplanationViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.title)
            Text(viewModel.message)
            Button(action: { Task { await self.viewModel.next() } }, label: { Text("Next") })
            Spacer()
        }
    }
}
