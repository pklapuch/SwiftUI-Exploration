import SwiftUI

@main
struct RouterNavigationApp: App {
    // MARK: - Application State (i.e. this is probaly derived or loaded from store)

    private var isLoggedIn = false
    private var hasCompletedOnboarding = false

    // MARK: Router

    private var router: Router!

    init() {
        router = Router(viewFactory: { route, mode in AnyView(Text("")) })
    }

    var body: some Scene {
        WindowGroup {
            let initialView = makeInitialView()

            RouterView(router: router) {
                

                if !isLoggedIn && !hasCompletedOnboarding {
                    makeWelcomeView()
                } else if !isLoggedIn {
                    makeLoginView()
                } else {
                    makeDashboardView()
                }
            }
        }
    }

    private func makeInitialView() -> AnyView {
        switch (isLoggedIn, hasCompletedOnboarding) {
        case (false, false):
            AnyView(makeWelcomeView())
        case (false, _):
            AnyView(makeLoginView())
        default:
            AnyView(makeDashboardView())
        }
    }
}


// MARK: - View Factory

private extension RouterNavigationApp {
    func makeView( _ route: Route, _ mode: PresentationMode) -> AnyView {
        switch route {
        case .welcome:
            AnyView(makeWelcomeView())
        case .explanation:
            AnyView(makeExplanationView())
        case .reuslt:
            AnyView(makeResultView())
        case .login:
            AnyView(makeLoginView())
        case .dashboard:
            AnyView(makeDashboardView())
        }
    }
}

// MARK: - Welcome View Factory

private extension RouterNavigationApp {
    private func makeWelcomeView() -> WelcomeView {
        let viewModel = makeWelcomeViewModel(router)
        return WelcomeView(viewModel: viewModel)
    }

    private func makeWelcomeViewModel(_ router: Router) -> WelcomeViewModel {
        WelcomeViewModel(
            showNextPage: { router.push(route: .explanation) }
        )
    }
}

// MARK: - Explanation View Factory

private extension RouterNavigationApp {
    private func makeExplanationView() -> ExplanationView {
        let viewModel = makeExplanationViewModel(router)
        return ExplanationView(viewModel: viewModel)
    }

    private func makeExplanationViewModel(_ router: Router) -> ExplanationViewModel {
        ExplanationViewModel(
            onNext: { router.push(route: .reuslt) },
            onRequestCamera: { /* AVFoundation... etc */ }
        )
    }
}

// MARK: - Result View Factory

private extension RouterNavigationApp {
    private func makeResultView() -> ResultView {
        let viewModel = makeResultViewModel(router)
        return ResultView(viewModel: viewModel)
    }

    private func makeResultViewModel(_ router: Router) -> ResultViewModel {
        ResultViewModel(
            onNext: { router.push(route: .login)  }
        )
    }
}

// MARK: - Login View Factory

private extension RouterNavigationApp {
    private func makeLoginView() -> LoginView {
        let viewModel = makeLoginViewModel(router)
        return LoginView(viewModel: viewModel)
    }

    private func makeLoginViewModel(_ router: Router) -> LoginViewModel {
        LoginViewModel(
            onDidLogin: { router.push(route: .dashboard) }
        )
    }
}

// MARK: - Dashboard View Factory

private extension RouterNavigationApp {
    private func makeDashboardView() -> DashboardView {
        let viewModel = makeDashboardViewModel(router)
        return DashboardView(viewModel: viewModel)
    }

    private func makeDashboardViewModel(_ router: Router) -> DashboardViewModel {
        DashboardViewModel(
            onLogout: { router.popToRoot() }
        )
    }
}
