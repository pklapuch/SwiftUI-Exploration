import SwiftUI

struct ContentView: View {
    @Bindable var viewModel = ViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            TextField(
                "Enter your name",
                text: Binding(
                    get: { viewModel.text },
                    set: { viewModel.perform(action: .editedText($0)) }
                )
            )

            Text("Value: \(viewModel.text)")
            Text("Is valid: \(viewModel.isValid ? "YES" : "NO")")
        }
    }
}

#Preview {
    ContentView()
}
