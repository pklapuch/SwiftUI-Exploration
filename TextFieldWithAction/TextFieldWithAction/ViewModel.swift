import SwiftUI

@Observable final class ViewModel {
    var text: String = ""
    var isValid = false

    func perform(action: Action) {
        switch action {
        case let .editedText(newText):
            text = newText
            validate()
        }
    }

    private func validate() {
        isValid = !text.isEmpty
    }
}
