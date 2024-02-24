import SwiftUI

struct RouterView<Content: View>: View {
    @ObservedObject var router: RouterViewModel
    private let rootContent: () -> Content
    private let contentFactory: ViewFactory

    init(
        router: RouterViewModel,
        rootContent: @escaping () -> Content,
        contentFactory: ViewFactory
    ) {
        self.router = router
        self.rootContent = rootContent
        self.contentFactory = contentFactory
    }

    var body: some View {
        NavigationStack(path: router.navigationPath) {
            rootContent()
                .navigationDestination(for: Route.self) { route in
                    contentFactory.make(route: route, mode: .navigation)
                }
        }
        .sheet(item: router.presentingSheet) { route in
            contentFactory.make(route: route, mode: .sheet)
        }
        .fullScreenCover(item: router.presentingFullScreen) { route in
            contentFactory.make(route: route, mode: .fullscreen)
        }
        .modal(item: router.presentingModal) { route in
            contentFactory.make(route: route, mode: .modal)
        }
    }
}
