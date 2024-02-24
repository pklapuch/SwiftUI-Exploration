import SwiftUI

final class DefaultViewFactory: ViewFactory {
    private let router: RouterViewModel

    init(router: RouterViewModel) {
        self.router = router
    }

    func make(route: Route, mode: PresentationMode) -> AnyView {
        AnyView(viewBuilder(route: route, mode: mode))
    }

    @ViewBuilder private func viewBuilder(route: Route, mode: PresentationMode) -> some View {
        switch route {
        case .welcome:
            makeWelcomeView()
        case .explanation:
            makeExplanationView()
        case .reuslt:
            makeResultView()
        case .login:
            makeLoginView()
        case .dashboard:
            makeDashboardView()
        case .privacyPolicy:
            makePrivacyPolicyView()
        }
    }

    // MARK: - Welcome View Factory

    func makeWelcomeView() -> WelcomeView {
        let viewModel = makeWelcomeViewModel(router)
        return WelcomeView(viewModel: viewModel)
    }

    private func makeWelcomeViewModel(_ router: RouterViewModel) -> WelcomeViewModel {
        WelcomeViewModel(
            showNextPage: { router.push(route: .explanation) }
        )
    }

    // MARK: - Explanation View Factory

    func makeExplanationView() -> ExplanationView {
        let viewModel = makeExplanationViewModel(router)
        return ExplanationView(viewModel: viewModel)
    }

    private func makeExplanationViewModel(_ router: RouterViewModel) -> ExplanationViewModel {
        ExplanationViewModel(
            onNext: { DispatchQueue.main.async { router.push(route: .reuslt) } },
            onRequestCamera: { /* AVFoundation... etc */ }
        )
    }

    // MARK: - Result View Factory

    func makeResultView() -> ResultView {
        let viewModel = makeResultViewModel(router)
        return ResultView(viewModel: viewModel)
    }

    private func makeResultViewModel(_ router: RouterViewModel) -> ResultViewModel {
        ResultViewModel(
            onNext: {
                container.hasCompletedOnboarding = true
                router.push(route: .login)
            }
        )
    }

    // MARK: - Login View Factory

    func makeLoginView() -> LoginView {
        let viewModel = makeLoginViewModel(router)
        return LoginView(viewModel: viewModel)
    }

    private func makeLoginViewModel(_ router: RouterViewModel) -> LoginViewModel {
        LoginViewModel(
            onDidLogin: { DispatchQueue.main.async { router.push(route: .dashboard) } }
        )
    }

    // MARK: - Dashboard View Factory

    func makeDashboardView() -> DashboardView {
        let viewModel = makeDashboardViewModel(router)
        return DashboardView(viewModel: viewModel)
    }

    private func makeDashboardViewModel(_ router: RouterViewModel) -> DashboardViewModel {
        DashboardViewModel(
            onShowPrivacyPolicy: { router.presentSheet(route: .privacyPolicy) },
            onLogout: {
                DispatchQueue.main.async { router.popToRoot() }
            }
        )
    }

    // MARK: - Privacy Policy View Factory

    func makePrivacyPolicyView() -> PrivacyPolicyView {
        let viewModel = makePrivacyPolicyViewModel(router)
        return PrivacyPolicyView(viewModel: viewModel)
    }

    private func makePrivacyPolicyViewModel(_ router: RouterViewModel) -> PrivacyPolicyViewModel {
        PrivacyPolicyViewModel(
            onClose: { router.dismissSheet() }
        )
    }
}
