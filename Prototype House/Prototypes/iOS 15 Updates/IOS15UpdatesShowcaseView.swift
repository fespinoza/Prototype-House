//
//  IOS15UpdatesShowcaseView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 18/11/2022.
//

import SwiftUI

extension IOS15UpdatesShowcaseView {
    class SampleViewController: UIViewController {
        override func viewDidLoad() {
            // Trying to understand how the button padding changes

            // https://sarunw.com/posts/new-way-to-style-uibutton-in-ios15/

            let horizontalPadding: CGFloat = 24
            let verticalPadding: CGFloat = 12

            // 'contentEdgeInsets' was deprecated in iOS 15.0: This property is ignored when using UIButtonConfiguration
            let firstButton = createButton(title: "Button #1")
            firstButton.contentEdgeInsets = UIEdgeInsets(vertical: verticalPadding, horizontal: horizontalPadding)

            let secondButton = createButton(title: "Button #2")

            let thirdButton = createButton(title: "Button #3")
            thirdButton.configuration = .plain() // this is necesary!
            thirdButton.configuration?.contentInsets = .init(vertical: verticalPadding, horizontal: horizontalPadding)

            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Config: \(thirdButton.configuration == nil ? "NIL" : "Found")"
            label.textColor = .purple
            view.addSubview(label)
            NSLayoutConstraint.activate([
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])

            view.addSubview(firstButton)
            view.addSubview(secondButton)
            view.addSubview(thirdButton)

            NSLayoutConstraint.activate([
                firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                firstButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),

                secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 20),

                thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                thirdButton.topAnchor.constraint(equalTo: secondButton.bottomAnchor, constant: 20),
            ])

            view.backgroundColor = .lightGray
        }

        func createButton(title: String) -> UIButton {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.clipsToBounds = true
            button.setTitle(title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .purple
            return button
        }
    }
}

struct IOS15UpdatesShowcaseView: View {
    var body: some View {
        ViewControllerRepresentable {
            SampleViewController()
        }
    }
}

struct IOS15UpdatesShowcaseView_Previews: PreviewProvider {
    static var previews: some View {
        IOS15UpdatesShowcaseView()
    }
}
