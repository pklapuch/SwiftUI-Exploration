import UIKit

extension UIApplication {
    var keyWindow: UIWindow? {
        let scenes = connectedScenes
        let scene = scenes.first { $0.activationState == .foregroundActive }
        guard let windowScene = scene as? UIWindowScene else { return nil }
        return windowScene.keyWindow
    }
}
