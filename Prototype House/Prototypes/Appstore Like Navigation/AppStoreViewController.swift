import UIKit

class AppStoreViewController: UIViewController {
    // MARK: Subviews

    private lazy var content: AppView = {
        let view = AppView(withAutoLayout: true)
        return view
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(withAutoLayout: true)
        scrollView.delegate = self
        // scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()

    private lazy var label: UILabel = {
        let label = UILabel(withAutoLayout: true)
        label.textColor = .white
        label.backgroundColor = .black
        label.text = "???"
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    private lazy var customTitleView: UIView = {
        let view = UIView()
        view.layoutMargins = UIEdgeInsets(vertical: 8, horizontal: 20)
        return view
    }()

    private lazy var customTitleLabel: UIView = {
        let imageView = UIImageView(withAutoLayout: true)
        imageView.fixed(size: 30)
        imageView.image = UIImage(named: "iconSmall")
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private var bottomConstraint: NSLayoutConstraint?

    // MARK: UIViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        customizeNavBar()
        customizeNavItem()
    }

    // MARK: private functions

    private func setupView() {
        view.backgroundColor = .purple

        let labelContainer = UIView(withAutoLayout: true)
        labelContainer.backgroundColor = .black
        labelContainer.layoutMargins = UIEdgeInsets(all: 8)

        view.addSubview(scrollView)
        view.addSubview(labelContainer)

        labelContainer.addSubview(label)
        label.pin(to: labelContainer.layoutMarginsGuide)

        scrollView.addSubview(content)

        scrollView.pinToSuperview()
        content.pinToSuperview()

        NSLayoutConstraint.activate([
            content.widthAnchor.constraint(equalTo: view.widthAnchor),

            labelContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])

        customTitleView.addSubview(customTitleLabel)

        bottomConstraint = customTitleLabel.bottomAnchor.constraint(
            equalTo: customTitleView.layoutMarginsGuide.bottomAnchor
        )
        bottomConstraint?.isActive = true

        NSLayoutConstraint.activate([
            customTitleLabel.topAnchor.constraint(equalTo: customTitleView.layoutMarginsGuide.topAnchor),
            customTitleLabel.leadingAnchor.constraint(equalTo: customTitleView.layoutMarginsGuide.leadingAnchor),
            customTitleLabel.trailingAnchor.constraint(equalTo: customTitleView.layoutMarginsGuide.trailingAnchor),
        ])
    }

    @objc private func onBookmarkTap(_ sender: Any?) {

    }

    private func customizeNavBar() {
        let navBar = navigationController?.navigationBar

        title = "Hello"

//        navBar?.prefersLargeTitles = true

//        navBar?.isHidden = true

        navBar?.barStyle = .default // black text by default => `.black` means white text

        // if the bar `isTranslucent` the content will have an inset
//        navBar?.isTranslucent = false // true by default

        // sets the tint color of the buttons
        navBar?.tintColor = .green

        // this only affects in the scroll state
//        navBar?.barTintColor = .yellow

//        customizeNavBarAppearance()
    }

    private func customizeNavBarAppearance() {
        let navBar = navigationController?.navigationBar
        // updates position of the text
//        navBar?.setTitleVerticalPositionAdjustment(10, for: .default)

        /*
         ## UINavigationBarAppearance

         The default value of this property is an appearance
         object containing the system's default appearance settings.
         You can customize the navigation bar appearance for
         specific navigation items with the standardAppearance property of UINavigationItem.

         **This appearance is used when scrolling**

         The appearance settings for a standard-height navigation bar.
         */
        let standardAppearance = navBar?.standardAppearance
        standardAppearance?.titleTextAttributes = [
            .foregroundColor: UIColor.orange,
        ]
        standardAppearance?.backgroundColor = .blue

        // when this is used? maybe iPad?
        // The appearance settings for a compact-height navigation bar.
        let compactAppearance = navBar?.compactAppearance
        compactAppearance?.titleTextAttributes = [
            .foregroundColor: UIColor.yellow,
        ]
        compactAppearance?.backgroundColor = .black

        // The appearance settings for the navigation bar when the
        // edge of scrollable content aligns with the edge of the navigation bar.
        let scrollEdgeAppearance = navBar?.scrollEdgeAppearance
        scrollEdgeAppearance?.titleTextAttributes = [
            .foregroundColor: UIColor.purple,
        ]
        scrollEdgeAppearance?.backgroundColor = .yellow

        // The appearance settings for a compact-height navigation bar when the
        // edge of scrollable content aligns with the edge of the navigation bar.
        if #available(iOS 15.0, *) {
            let compactScrollEdgeAppearance = navBar?.compactScrollEdgeAppearance
            compactScrollEdgeAppearance?.titleTextAttributes = [
                .foregroundColor: UIColor.blue,
            ]
            compactScrollEdgeAppearance?.backgroundColor = .cyan
        } else {
        }
    }

    private func customizeNavItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .bookmarks,
            target: self,
            action: #selector(onBookmarkTap)
        )

//        let appearance = navigationItem.standardAppearance
//        appearance?.backgroundColor = .red

        // A custom view that displays in the center of the
        // navigation bar when the receiver is the top item.

        /*
            If this property value is nil, the navigation item’s title is
            displayed in the center of the navigation bar when the receiver
            is the top item. If you set this property to a custom title,
            it is displayed instead of the title.

            Custom views can contain buttons. Use the init(type:) method
            in UIButton class to add buttons to your custom view in the
            style of the navigation bar.

            Custom title views are centered on the navigation bar and
            may be resized to fit.

            The default value is nil.
         */
        navigationItem.titleView = customTitleView
    }

    /*

     TODO: how to get the frame of a child view in the scroll view coordinates?
     */
    var titleCoordinates: CGRect {
        let titleFrame = content
            .header
            .titleLabel
            .frame

        return view.convert(titleFrame, from: content.header.titleLabel)

//        return titleFrame
    }

    lazy var titleAlpha: (CGFloat) -> CGFloat = {
        LinearEquation.segmentedLinearEquation(
            fromPoint: .init(x: 90, y: 0),
            toPoint: .init(x: 130, y: 1)
        )
    }()

    lazy var titleBottomConstant: (CGFloat) -> CGFloat = {
        LinearEquation.segmentedLinearEquation(
            fromPoint: .init(x: 90, y: 20),
            toPoint: .init(x: 130, y: 0)
        )
    }()

    private func updateBarContent(for offset: CGFloat) {
        customTitleLabel.alpha = titleAlpha(offset)
        bottomConstraint?.constant = titleBottomConstant(offset)
    }
}

extension AppStoreViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if #available(iOS 15.0, *) {
            label.text = "currentOffset: " + scrollView.contentOffset.y
                .formatted(FloatingPointFormatStyle<CGFloat>().precision(.significantDigits(2)))
//            + "\ntitleFrame: \(titleCoordinates.maxY)"
        } else {
            label.text = "\(scrollView.contentOffset.y)"
        }
        updateBarContent(for: scrollView.contentOffset.y)
    }
}

import SwiftUI

struct AppStoreView_Previews: PreviewProvider {
    static let appStoreContainer: UIViewController = {
        let appStoreView = AppStoreViewController()
        return UINavigationController(rootViewController: appStoreView)
    }()

    static var previews: some View {
        DemoWrapperViewController(viewController: appStoreContainer)
            .ignoresSafeArea()
            .preferredColorScheme(.dark)
    }
}
