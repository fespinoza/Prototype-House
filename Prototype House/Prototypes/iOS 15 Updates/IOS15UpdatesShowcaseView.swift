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

            // ⚠️ 'contentEdgeInsets' was deprecated in iOS 15.0: This property is ignored when using UIButtonConfiguration
            let firstButton = createButton(title: "Button #1")
//            firstButton.contentEdgeInsets = UIEdgeInsets(vertical: verticalPadding, horizontal: horizontalPadding)

            let secondButton = createButton(title: "Button #2")

            let thirdButton = createButton(title: "Button #3")
            thirdButton.configuration = .plain() // this is necesary!
            thirdButton.configuration?.contentInsets = .init(vertical: verticalPadding, horizontal: horizontalPadding)

            let fourthButton = createButton()
            fourthButton.setImage(UIImage(systemName: "swift"), for: .normal)
            fourthButton.tintColor = .orange

            // ⚠️ 'imageEdgeInsets' was deprecated in iOS 15.0: This property is ignored when using UIButtonConfiguration
//             fourthButton.imageEdgeInsets = UIEdgeInsets(all: horizontalPadding)


            fourthButton.configuration = .plain() // this is necesary!
            fourthButton.configuration?.contentInsets = .init(all: horizontalPadding)
//            fourthButton.configuration?.imagePadding = horizontalPadding

            let fifthButton = UIButton(withAutoLayout: true)
            fifthButton.setImage(UIImage(systemName: "xmark"), for: .normal)
            fifthButton.tintColor = .orange
//            fifthButton.imageEdgeInsets = UIEdgeInsets(all: 12) // this looks broken
            fifthButton.fixed(size: 48)
            fifthButton.backgroundColor = .purple

            // ⚠️ 'titleEdgeInsets' was deprecated in iOS 15.0: This property is ignored when using UIButtonConfiguration
            let sixthButton = UIButton(withAutoLayout: true)
            sixthButton.setImage(UIImage(systemName: "plus"), for: .normal)
            sixthButton.titleLabel?.lineBreakMode = .byWordWrapping
            sixthButton.setTitleColor(.purple, for: .normal)
            sixthButton.contentHorizontalAlignment = .leading
    //        button.configuration = .plain()
            sixthButton.setTitle("Add To Calendar", for: .normal)
            sixthButton.backgroundColor = .orange.withAlphaComponent(0.4)

            sixthButton.configuration = .plain()
            sixthButton.configuration?.imagePadding = 12
//            sixthButton.titleEdgeInsets = .init(horizontal: 12)

            view.addSubview(firstButton)
            view.addSubview(secondButton)
            view.addSubview(thirdButton)
            view.addSubview(fourthButton)
            view.addSubview(fifthButton)
            view.addSubview(sixthButton)

            NSLayoutConstraint.activate([
                firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                firstButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),

                secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 20),

                thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                thirdButton.topAnchor.constraint(equalTo: secondButton.bottomAnchor, constant: 20),

                fourthButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                fourthButton.topAnchor.constraint(equalTo: thirdButton.bottomAnchor, constant: 20),

                fifthButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                fifthButton.topAnchor.constraint(equalTo: fourthButton.bottomAnchor, constant: 20),

                sixthButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                sixthButton.topAnchor.constraint(equalTo: fifthButton.bottomAnchor, constant: 20),
            ])

            view.backgroundColor = .lightGray
        }

        func createButton(title: String? = nil) -> UIButton {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.clipsToBounds = true
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .purple

            if let title {
                button.setTitle(title, for: .normal)
            }

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
