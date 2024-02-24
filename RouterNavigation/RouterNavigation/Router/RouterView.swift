import SwiftUI

struct RouterView<Content: View>: View {
    @ObservedObject var viewModel: RouterViewModel
    private let rootContent: () -> Content
    private let contentFactory: ViewFactory

    init(
        viewModel: RouterViewModel,
        rootContent: @escaping () -> Content,
        contentFactory: ViewFactory
    ) {
        self.viewModel = viewModel
        self.rootContent = rootContent
        self.contentFactory = contentFactory
    }

    var body: some View {
        NavigationStack(path: viewModel.navigationPath) {
            rootContent()
                .navigationDestination(for: Route.self) { route in
                    contentFactory.make(route: route, mode: .navigation)
                }
        }
        .sheet(item: viewModel.presentingSheet) { route in
            contentFactory.make(route: route, mode: .sheet)
        }
        .fullScreenCover(item: viewModel.presentingFullScreen) { route in
            contentFactory.make(route: route, mode: .fullscreen)
        }
        .modal(item: viewModel.presentingModal) { route in
            contentFactory.make(route: route, mode: .modal)
        }
    }
}
