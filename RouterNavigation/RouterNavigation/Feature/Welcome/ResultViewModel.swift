import Foundation

final class ResultViewModel: ObservableObject {
    typealias OnNext = () -> Void

    @Published private(set) var title: String
    @Published private(set) var message: String

    private let onNext: OnNext

    init(onNext: @escaping OnNext) {
        self.onNext = onNext
        self.title =  "Result View Title"
        self.message = "Result View Message"
    }

    func next() {
        onNext()
    }
}
