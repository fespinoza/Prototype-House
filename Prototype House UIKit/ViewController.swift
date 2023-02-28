import UIKit
import SwiftUI

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Initial Controller"

        // 44 pts total area
        // 28 pts image size
//        let share = UIBarButtonItem(
//            image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: nil, action: nil
//        )
//        share.style = .plain
//        share.setBackgroundImage(
//            UIImage.solid(color: .orange, size: CGSize(width: 44, height: 44)), for: .normal, barMetrics: .default
//        )

        // ==== UIkit button
//        let profile = UIBarButtonItem(
//            image: UIImage(systemName: "person.circle"), style: .plain, target: nil, action: nil
//        )
//        profile.setBackgroundImage(
//            UIImage.solid(color: .red, size: CGSize(width: 44, height: 44)), for: .normal, barMetrics: .default
//        )

        // ==== UIkit customView
//        let profile = UIBarButtonItem(customView: uikitImage(name: "person.circle"))

        let share = UIBarButtonItem(customView: swiftUIImage(name: "square.and.arrow.up"))
        let profile = UIBarButtonItem(customView: swiftUIImage(name: "person.circle"))

        navigationItem.rightBarButtonItems = [
            profile,
            share
        ]
    }

    func uikitImage(name: String) -> UIView {
        let image = UIImage(systemName: name)?.applyingSymbolConfiguration(.init(pointSize: 22))
        let imageView = UIImageView(image: image)
        imageView.sizeToFit()
        return imageView
    }

    func swiftUIImage(name: String) -> UIView {
        let hostingController = UIHostingController(
            rootView: Button(action: {}) {
                Image(systemName: name)
                    .font(.system(size: 22))

                // DO not use this approach: https://nilcoalescing.com/blog/ResizingSFSymbolsInSwiftUI/
//                    .resizable()
//                    .frame(width: 28, height: 28)
            }
            .frame(width: 44, height: 44)
//            .background(Color.red)
        )
        return hostingController.view
    }
}
