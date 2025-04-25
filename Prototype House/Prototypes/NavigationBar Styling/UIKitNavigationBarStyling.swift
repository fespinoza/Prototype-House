import Foundation
import UIKit

class ScrollableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Create Scroll View
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        // Constraints for Scroll View
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // Create Content View
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        // Constraints for Content View
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        // Create Stack View
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)

        // Constraints for Stack View
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])

        // Add Sample Views
        for i in 1...40 {
            let label = UILabel()
            label.text = "Label \(i)"
            label.textAlignment = .center
            label.backgroundColor = .lightGray
            label.heightAnchor.constraint(equalToConstant: 50).isActive = true
            stackView.addArrangedSubview(label)
        }

        navigationItem.title = "Very long content that can be cropped even though is reasonably large"
        navigationController?.navigationBar.prefersLargeTitles = true

        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineBreakMode = .byTruncatingHead
        paragraphStyle.allowsDefaultTighteningForTruncation = true
        paragraphStyle.lineBreakStrategy = []

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .blue
        appearance.largeTitleTextAttributes = [
            .font: UIFont.preferredFont(forTextStyle: .largeTitle),
            .paragraphStyle: paragraphStyle,
        ]
        navigationItem.scrollEdgeAppearance = appearance
//        (navigationItem.titleView as? UILabel)?.text = "Hello"

        navigationController?.navigationBar.standardAppearance.backgroundColor = .red

        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "This is a\nmultiline string for the navBar"
//        self.navigationItem.titleView = label

//        for navItem in (navigationController?.navigationBar.subviews)! {
//            for itemSubView in navItem.subviews {
//                if let largeLabel = itemSubView as? UILabel {
//                    largeLabel.text = self.title
//                    largeLabel.numberOfLines = 0
//                    largeLabel.lineBreakMode = .byWordWrapping
//                    largeLabel.textColor = .orange
//                }
//            }
//        }

        navigationItem.backButtonTitle = "Something!"
    }
}


#Preview {
    UINavigationController(rootViewController: ScrollableViewController())
}
