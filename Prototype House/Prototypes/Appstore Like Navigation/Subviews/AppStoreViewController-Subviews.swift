//
//  AppStoreViewController-Subviews.swift
//  SATS Playground
//
//  Created by Felipe Espinoza on 23/11/2021.
//

import UIKit

class HeaderView: UIView {
    // MARK: Subviews

    lazy var bannerImage: UIView = {
        let view = UIView(withAutoLayout: true)
        view.backgroundColor = .purple
        view.fixed(height: 150)
        return view
    }()

    lazy var appIcon: UIImageView = {
        let imageView = UIImageView(withAutoLayout: true)
        imageView.fixed(size: 60)
//        imageView.backgroundColor = .orange
        imageView.image = UIImage(named: "iconSmall")
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel(withAutoLayout: true)
        label.font = .preferredFont(forTextStyle: .title2, compatibleWith: .current)
        return label
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel(withAutoLayout: true)
        label.font = .preferredFont(forTextStyle: .subheadline, compatibleWith: .current)
        return label
    }()

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }

    // MARK: UIView overrides

    // MARK: Internal methods

    func configure() {
        titleLabel.text = "Generic App! Play & Create Quizzes"
        subtitleLabel.text = "Learn at school, home or work"
    }

    // MARK: Private methods

    private func setup() {
        let container = UIView(withAutoLayout: true)
        container.layoutMargins = UIEdgeInsets(all: 10)

        addSubview(bannerImage)
        addSubview(container)

        container.addSubview(appIcon)
        container.addSubview(titleLabel)
        container.addSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            bannerImage.topAnchor.constraint(equalTo: topAnchor),
            bannerImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            bannerImage.trailingAnchor.constraint(equalTo: trailingAnchor),

            container.topAnchor.constraint(equalTo: bannerImage.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),

            appIcon.topAnchor.constraint(equalTo: container.layoutMarginsGuide.topAnchor),
            appIcon.leadingAnchor.constraint(equalTo: container.layoutMarginsGuide.leadingAnchor),

            titleLabel.topAnchor.constraint(equalTo: container.layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: appIcon.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: container.layoutMarginsGuide.trailingAnchor),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: appIcon.trailingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: container.layoutMarginsGuide.trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: container.layoutMarginsGuide.bottomAnchor),
        ])
    }
}

class AppView: UIView {

    // MARK: Subviews

    private func demoLabel(_ text: String) -> UILabel {
        let label = UILabel(withAutoLayout: true)
        label.text = text
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.backgroundColor = .blue
        return label
    }

    lazy var longContent: UIStackView = {
        let stackView = UIStackView(withAutoLayout: true)
        stackView.axis = .vertical
        stackView.spacing = 600
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        return stackView
    }()

    lazy var header: HeaderView = {
        let view = HeaderView(withAutoLayout: true)
        view.configure()
        return view
    }()

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }

    // MARK: Private methods

    private func setup() {
        backgroundColor = .lightGray

        let stackView = UIStackView(withAutoLayout: true)
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill

        addSubview(stackView)

        [
            header,
            longContent,
        ].forEach(stackView.addArrangedSubview)

        [
            demoLabel("Top"),
            demoLabel("Sample #2"),
            demoLabel("Sample #3"),
            demoLabel("Bottom"),
        ].forEach(longContent.addArrangedSubview)

        stackView.pinToSuperview()

//        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: topAnchor),
//            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
//        ])
    }
}

import SwiftUI

struct HeaderView_Previews: PreviewProvider {
    static var view: UIView = {
        let headerView = HeaderView()
        headerView.configure()
        return view
    }()

    static var previews: some View {
        DemoWrapperView(view: view)
    }
}
