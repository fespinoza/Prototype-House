//
//  ScrollableContentView.swift
//  Prototype House UIKit
//
//  Created by Felipe Espinoza on 09/03/2023.
//

import UIKit

class ScrollableContentView: UIView {
    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
         // Drawing code
     }
     */

    func setup() {
        let topLabel = label(text: "Top label")
        let centerLabel = label(text: "Center label")
        let bottomLabel = label(text: "Bottom label")

        translatesAutoresizingMaskIntoConstraints = false

        addSubview(topLabel)
        addSubview(centerLabel)
        addSubview(bottomLabel)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 1500),

            topLabel.topAnchor.constraint(equalTo: topAnchor),
            topLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            centerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            centerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }

    func label(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
