//
//  TvAppContentView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 29/06/2022.
//

import SwiftUI
import UIKit

class TvAppContentView: UIView {

    // MARK: Subviews
//    private lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView(withAutoLayout: true)
//        return scrollView
//    }()

    private lazy var bannerImageView: UIImageView = {
        let image = UIImageView(withAutoLayout: true)
        image.backgroundColor = .orange
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()

    private lazy var bannerGradient: UIView = {
        let controller = UIHostingController(rootView: LinearGradient(
            stops: [
                .init(color: .clear, location: 0),
                .init(color: .clear, location: 0.5),
                .init(color: .black.opacity(0.7), location: 0.8),
                .init(color: .black, location: 1),
            ],
            startPoint: .top,
            endPoint: .bottom
        ))
        controller.view.backgroundColor = .clear
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        return controller.view
    }()

    private lazy var spacerView: UIView = {
        let view = UIView(withAutoLayout: true)
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel(withAutoLayout: true)
        label.font = .systemFont(ofSize: 60, weight: .black)
        label.textAlignment = .center
        return label
    }()

    private lazy var actionButtonContainer: UIView = {
        let controller = UIHostingController(
            rootView: Button(action: {}) {
                Text("Get Apple TV+")
                    .bold()
                    .padding(.vertical, 8)
                    .padding(.horizontal, 32)
            }
                .buttonStyle(.borderedProminent)
                .tint(.white)
                .foregroundColor(.black)
        )

        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.backgroundColor = .clear
        return controller.view
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(withAutoLayout: true)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .body)
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

    func configure(with viewData: TvAppContentViewData) {
        bannerImageView.image = viewData.bannerImage
        titleLabel.text = viewData.title.uppercased()
        descriptionLabel.text = viewData.description
    }

    // MARK: Private methods

    private func setup() {
        backgroundColor = .systemBackground

        let stack = UIStackView(withAutoLayout: true)
        stack.axis = .vertical
        stack.spacing = 16
        stack.layoutMargins = UIEdgeInsets(horizontal: 16)
        stack.isLayoutMarginsRelativeArrangement = true

        stack.addArrangedSubview(spacerView)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(actionButtonContainer)
        stack.addArrangedSubview(descriptionLabel)

        bannerImageView.addSubview(bannerGradient)
        bannerGradient.pin(to: bannerImageView)

        addSubview(bannerImageView)
        addSubview(stack)

//        addSubview(scrollView)
//        scrollView.addSubview(stack)
//        scrollView.pin(to: self)

        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: 400),

            actionButtonContainer.heightAnchor.constraint(equalToConstant: 60),
            actionButtonContainer.widthAnchor.constraint(equalToConstant: 100),

            spacerView.heightAnchor.constraint(equalToConstant: 300),

            stack.widthAnchor.constraint(equalTo: widthAnchor),
        ])
        stack.pinToSuperview()
    }
}

import SwiftUI

struct TvAppContentView_Previews: PreviewProvider {
    static let tvAppContainer: UIView = {
        let tvApp = TvAppContentView(withAutoLayout: true)
        tvApp.configure(with: .tedLasso)

        let containerView = UIView()
        containerView.backgroundColor = .lightGray
        containerView.addSubview(tvApp)
        tvApp.pin(to: containerView)

        return containerView
    }()

    static var previews: some View {
        DemoWrapperView(view: tvAppContainer)
            .ignoresSafeArea()
            .preferredColorScheme(.dark)
    }
}


