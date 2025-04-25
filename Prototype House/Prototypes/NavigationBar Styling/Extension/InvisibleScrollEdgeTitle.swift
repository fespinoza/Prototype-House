import SwiftUI
import SwiftUIIntrospect

extension View {
    func invisibleScrollEdgeTitle() -> some View {
        introspect(.viewController, on: .iOS(.v18)) { controller in
            let scrollEdge = UINavigationBarAppearance()
            scrollEdge.configureWithTransparentBackground()
            scrollEdge.titleTextAttributes = [.foregroundColor: UIColor.clear]

            controller.navigationItem.scrollEdgeAppearance = scrollEdge
        }
    }
}
