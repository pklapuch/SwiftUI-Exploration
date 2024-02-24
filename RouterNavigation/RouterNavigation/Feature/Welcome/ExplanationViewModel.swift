import Foundation

final class ExplanationViewModel: ObservableObject {
    typealias OnNext = () -> Void
    typealias OnRequestCamera = () async -> Void

    @Published private(set) var title: String
    @Published private(set) var message: String

    private let onNext: OnNext
    private let onRequestCamera: OnRequestCamera

    init(
        onNext: @escaping OnNext,
        onRequestCamera: @escaping OnRequestCamera
    ) {
        self.onNext = onNext
        self.onRequestCamera = onRequestCamera
        self.title =  "Explanation View Title"
        self.message = "Explanation View Message"
    }

    func next() async {
        await onRequestCamera()
        onNext()
    }
}
