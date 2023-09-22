//
//  SegmentedExperimentViewController.swift
//  Prototype House UIKit
//
//  Created by Felipe Espinoza on 04/08/2023.
//

import UIKit
import SwiftUI

class SegmentedExperimentViewController: UIViewController {
    let control = UISegmentedControl(items: ["One", "Two"])
    let pageContainer = UIPageViewController()
    let blue: UIViewController = buildSampleController(color: .blue)
    let red: UIViewController = buildSampleController(color: .red)

    override func viewDidLoad() {
        super.viewDidLoad()

//        setupContent()

        setupSegmentedControl()
        setupPageControl()
    }

    private func setupSegmentedControl() {
        control.addAction(UIAction(handler: { [weak self] action in
            guard let self else { return }
            print("segmented control, \(control.selectedSegmentIndex)")

            pageContainer.setViewControllers(
                control.selectedSegmentIndex == 0 ? [blue] : [red],
                direction: .forward,
                animated: true
            )
        }), for: .valueChanged)

        navigationItem.titleView = control
    }

    private func setupPageControl() {
//        pageContainer.dataSource = self
        pageContainer.setViewControllers([
            blue,
        ], direction: .forward, animated: false)
        view.addSubview(pageContainer.view)
        NSLayoutConstraint.activate([
            pageContainer.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pageContainer.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageContainer.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageContainer.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private static func buildSampleController(color: UIColor) -> UIViewController {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        let content = ScrollableContentView()
        content.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(content)

        let viewController = UIViewController()
        viewController.view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor),

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
        ])

        content.backgroundColor = color
        return viewController
    }
}
//
//extension SegmentedExperimentViewController: UIPageViewControllerDataSource {
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        
//    }
//    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//
//    }
//    
//
//}


#Preview {
    SegmentedExperimentViewController()
}
