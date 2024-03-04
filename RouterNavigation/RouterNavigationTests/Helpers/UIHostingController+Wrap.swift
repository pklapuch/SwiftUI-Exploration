import SwiftUI

extension UIHostingController {
    static func wrap(view: Content) -> UIHostingController {
        let vc = UIHostingController(rootView: view)
        vc.view.frame = UIScreen.main.bounds
        return vc
    }
}
