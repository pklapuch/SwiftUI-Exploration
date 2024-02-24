import SwiftUI

struct RouterView<Content: View>: View {
    @ObservedObject var router: Router
    private let content: Content

    init(router: Router, @ViewBuilder content: @escaping () -> Content) {
        self.router = router
        self.content = content()
    }

    var body: some View {
        NavigationStack(path: router.navigationPath) {
            content
                .navigationDestination(for: Route.self) { route in
                    router.view(for: route, mode: .navigation)
                }
        }
    }
}

/*
 .sheet(item: router.presentingSheet) { spec in
     router.view(spec: spec, route: .sheet)
 }.fullScreenCover(item: router.presentingFullScreen) { spec in
     router.view(spec: spec, route: .fullScreenCover)
 }.modal(item: router.presentingModal) { spec in
     router.view(spec: spec, route: .modal)
 }
 */
