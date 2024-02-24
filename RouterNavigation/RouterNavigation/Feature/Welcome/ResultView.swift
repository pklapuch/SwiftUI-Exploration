import SwiftUI

struct ResultView: View {
    @ObservedObject var viewModel: ResultViewModel

    init(viewModel: ResultViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.title)
            Text(viewModel.message)
            Button(action: { Task { self.viewModel.next() } }, label: { Text("Next") })
            Spacer()
        }
    }
}
