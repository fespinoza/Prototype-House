//
//  AlertTextOnUIkit.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 02/06/2022.
//

import Foundation
import UIKit

class AlertTextContainer: UIViewController {
    var content: String = "" {
        didSet {
            contentLabel.text = content
        }
    }

    private lazy var titleText: UILabel = {
        let label = UILabel(withAutoLayout: true)
        label.text = "Hello World"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()

    private lazy var contentLabel: UILabel = {
        let label = UILabel(withAutoLayout: true)
        label.text = "Sample"
        return label
    }()

    private lazy var actionButton: UIButton = {
        let button = UIButton(withAutoLayout: true)
        button.setTitle("Trigger!", for: .normal)
        button.addTarget(self, action: #selector(presentAlert), for: .touchUpInside)
        button.backgroundColor = .purple
        return button
    }()

    private lazy var contentStack: UIStackView = {
        let stackView = UIStackView(withAutoLayout: true)
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.alignment = .center
        return stackView
    }()

    override func viewDidLoad() {

        view.addSubview(contentStack)

        contentStack.addArrangedSubview(titleText)
        contentStack.addArrangedSubview(contentLabel)
        contentStack.addArrangedSubview(actionButton)

        contentStack.centerAndConstraintInSuperview()
    }

    @objc func presentAlert() {
        let alert = createAlert { newText in
            self.content = newText
        }
        present(alert, animated: true)
    }

    private func createAlert(onSubmit: @escaping (String) -> Void) -> UIAlertController {
        let alertController = UIAlertController(
            title: "Title",
            message: "Message",
            preferredStyle: .alert
        )
        alertController.addTextField { textField in
            textField.placeholder = "New text"
        }
        alertController.addAction(
            .init(title: "OK", style: .default, handler: { [weak alertController] action in
                let text = alertController?.textFields?.first?.text ?? ""
                onSubmit(text)
            })
        )
        alertController.addAction(
            .init(title: "Nah", style: .cancel)
        )

        return alertController
    }
}

import SwiftUI

struct AlertWithTextFieldSampleViewUIKit_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable {
            AlertTextContainer()
        }
    }
}

