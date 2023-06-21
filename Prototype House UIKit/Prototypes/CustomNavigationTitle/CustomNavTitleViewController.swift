//
//  CustomNavTitleViewController.swift
//  Prototype House UIKit
//
//  Created by Felipe Espinoza on 09/03/2023.
//

import UIKit
import SwiftUI

class CustomNavTitleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.titleView = titleView()

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        let content = ScrollableContentView()
        content.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)

        scrollView.addSubview(content)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            content.topAnchor.constraint(equalTo: scrollView.topAnchor),
            content.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            content.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            {
                let constraint = content.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
                constraint.priority = .defaultLow
                return constraint
            }(),
            content.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
//            content.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
        ])


    }

    func titleView() -> UIView {
        let hostingController = UIHostingController(rootView: HStack {
            Image("iron-profile").resizable().scaledToFill().frame(width: 30, height: 30).clipShape(Circle())
            Text("Hello world")
        })
        hostingController.view.backgroundColor = .clear
        return hostingController.view
    }
}
