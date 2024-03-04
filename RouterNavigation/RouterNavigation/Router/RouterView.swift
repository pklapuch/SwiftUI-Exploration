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
                        .onAppear { viewModel.didShow(route: route) }
                }
        }
        .sheet(item: viewModel.presentingSheet) { route in
            contentFactory.make(route: route, mode: .sheet)
                .onAppear { viewModel.didShow(route: route) }
        }
        .fullScreenCover(item: viewModel.presentingFullScreen) { route in
            contentFactory.make(route: route, mode: .fullscreen)
                .onAppear { viewModel.didShow(route: route) }
        }
        .modal(item: viewModel.presentingModal) { route in
            contentFactory.make(route: route, mode: .modal)
                .onAppear { viewModel.didShow(route: route) }
        }
        .alert("Test", isPresented: viewModel.presentingAlert, actions: {})
    }
}
