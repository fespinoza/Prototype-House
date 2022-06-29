//
//  TvAppContentViewController.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 29/06/2022.
//

import UIKit

class TvAppContentViewController: UIViewController {
    let viewData: TvAppContentViewData

    init(viewData: TvAppContentViewData = .tedLasso) {
        self.viewData = viewData
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(withAutoLayout: true)
        return scrollView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let newScrollAppearance = UINavigationBarAppearance()
        newScrollAppearance.configureWithTransparentBackground()
        newScrollAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.clear
        ]

        let newStandardAppearance = UINavigationBarAppearance()
        newStandardAppearance.configureWithOpaqueBackground()
        newStandardAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.systemYellow
        ]

        navigationItem.scrollEdgeAppearance = newScrollAppearance
        navigationItem.standardAppearance = newStandardAppearance

//        let navigationBar = navigationController?.navigationBar

//        navigationBar?.scrollEdgeAppearance?.backgroundColor = .red
//        navigationBar?.scrollEdgeAppearance?.backgroundEffect = nil
//        navigationBar?.scrollEdgeAppearance?.backgroundImage = nil
//
//        navigationBar?.standardAppearance.backgroundColor = .blue
//        navigationBar?.standardAppearance.backgroundEffect = nil
//        navigationBar?.standardAppearance.backgroundImage = nil

        navigationItem.largeTitleDisplayMode = .never

        let translucentMessage: String
        switch navigationController?.navigationBar.isTranslucent {
        case .some(true): translucentMessage = "YES"
        case .some(false): translucentMessage = "NO"
        case .none: translucentMessage = "NIL"
        }

        debugMessage(text: "isTranslucent = \(translucentMessage)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Ted Lasso"

        setupContentWithNestedScrollView()
        addDebugLabel(to: view)
        setDebugLabel(scrollLabel)
    }

    func setupContentWithNestedScrollView() {
        let contentView = TvAppScrollableContentView(withAutoLayout: true)
        contentView.configure(with: viewData)

        view.addSubview(contentView)
        contentView.pin(to: view)

        // ⚠️ this made the right scroll view connection!
        setContentScrollView(contentView.scrollView)
        contentView.scrollView.delegate = self
    }

    func setupScrollViewWithContent() {
        let contentView = TvAppContentView(withAutoLayout: true)
        contentView.configure(with: viewData)

        // the scroll view seems to be needed on top of the content
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pin(to: view)
        contentView.pinToSuperview()
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }

    private lazy var scrollLabel: UILabel = {
        let label = UILabel(withAutoLayout: true)
        label.text = "--"
        label.textColor = .black
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.backgroundColor = .orange
        label.textAlignment = .center
        label.layer.cornerRadius = 24
        return label
    }()

    func updateScrollOffset(to newPoint: CGPoint) {
        let contentOffsetMessage = String.localizedStringWithFormat(
            "%.2f", newPoint.y
        )
        scrollLabel.text = "offY = \(contentOffsetMessage)"
    }

    lazy var titleAlpha: (CGFloat) -> CGFloat = {
        LinearEquation.segmentedLinearEquation(
            fromPoint: .init(x: 237, y: 0),
            toPoint: .init(x: 282, y: 1)
        )
    }()

    lazy var titlePosition: (CGFloat) -> CGFloat = {
        LinearEquation.segmentedLinearEquation(
            fromPoint: .init(x: 237, y: 40),
            toPoint: .init(x: 282, y: 0)
        )
    }()

    lazy var backgroundAlpha: (CGFloat) -> CGFloat = {
        LinearEquation.segmentedLinearEquation(
            fromPoint: .init(x: 150, y: 0),
            toPoint: .init(x: 282, y: 1)
        )
    }()

    func updateTitleAlpha(scrollY: CGFloat) {
        navigationItem.standardAppearance?.titleTextAttributes = [
            .foregroundColor: UIColor.systemPink.withAlphaComponent(titleAlpha(scrollY))
        ]
        navigationItem.standardAppearance?.titlePositionAdjustment = .init(
            horizontal: 0,
            vertical: titlePosition(scrollY)
        )
    }

    func updateBackgroundOpacity(scrollY: CGFloat) {
//        let image = navigationItem.standardAppearance?.backIndicatorImage
//        let effect = navigationItem.standardAppearance?.backgroundEffect
        navigationItem.standardAppearance?.backgroundColor = UIColor.blue.withAlphaComponent(
            backgroundAlpha(scrollY)
        )
    }
}

extension TvAppContentViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateScrollOffset(to: scrollView.contentOffset)
        updateTitleAlpha(scrollY: scrollView.contentOffset.y)
        updateBackgroundOpacity(scrollY: scrollView.contentOffset.y)
    }
}

class TvAppIndexViewController: UIViewController {
    var navigateImmediatelly: Bool

    private lazy var bannerImageView: UIImageView = {
        let view = UIImageView(withAutoLayout: true)
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "london")
        return view
    }()

    private lazy var actionButton: UIButton = {
        let button = UIButton(configuration: .borderedTinted(), primaryAction: UIAction(handler: { action in
            self.navigateToShow()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ted Lasso", for: .normal)
        return button
    }()

    init(navigateImmediatelly: Bool = false) {
        self.navigateImmediatelly = navigateImmediatelly
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        title = "TV Show App"
        view.addSubview(actionButton)
        actionButton.center(in: view)
        addDebugLabel(to: view)

        if navigateImmediatelly {
            navigateToShow()
        }

        navigationController?.navigationBar.prefersLargeTitles = true

        let prefers = navigationController?.navigationBar.prefersLargeTitles ?? false
        debugMessage(text: "prefersLargeTitle: \(prefers ? "TRUE" : "FALSE")")

        navigationItem.backButtonTitle = "Back"
//        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.largeTitleDisplayMode = .always
    }

    func navigateToShow() {
        navigationController?.pushViewController(TvAppContentViewController(), animated: true)
    }
}

extension UIViewController {
    func addDebugLabel(to view: UIView) {
        let message = UUID().uuidString.split(separator: "-").first.map { String($0) }
        debugMessage(text: message, color: .red)
    }

    private func createDebugStack() -> UIStackView {
        let stackView = UIStackView(withAutoLayout: true)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.restorationIdentifier = "DEBUG_STACK"

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

        return stackView
    }

    func debugMessage(text: String?, color: UIColor = .systemPurple) {
        let label = UILabel(withAutoLayout: true)
        label.text = text
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.backgroundColor = color
        label.textAlignment = .center
        label.layer.cornerRadius = 24

        setDebugLabel(label)
    }

    func setDebugLabel(_ label: UILabel) {
        let debugStack: UIStackView
        if let stack = view.subviews.first(where: { $0.restorationIdentifier == "DEBUG_STACK" }) as? UIStackView {
            debugStack = stack
        } else {
            debugStack = createDebugStack()
        }

        debugStack.addArrangedSubview(label)
    }
}

import SwiftUI

struct TvAppIndexViewController_Previews: PreviewProvider {
    static var previews: some View {
        DemoWrapperViewController(
            viewController: UINavigationController(
                rootViewController: TvAppIndexViewController(navigateImmediatelly: true)
            )
        )
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
    }
}
