import SwiftUI

protocol ViewFactory {
    func make(route: Route, mode: PresentationMode) -> AnyView
}
