import Foundation

enum Route: Equatable, Hashable {
    case welcome
    case explanation
    case reuslt
    case login
    case dashboard
}

extension Route: Identifiable {
    var id: Self { self }
}
