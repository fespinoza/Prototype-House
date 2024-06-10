//
//  SuggestionsWindowControllerAlt.swift
//  Prototype House Mac
//
//  Created by Felipe Espinoza on 05/06/2024.
//

import Foundation

// originally taken from: https://github.com/lucasderraugh/AppleProg-Cocoa-Tutorials/blob/master/Lesson%2090/CustomSearchSuggestionsWindow/SuggestionsWindowController.swift

import Cocoa
import SwiftUI

class SuggestionsWindowControllerAlt: NSWindowController {

    private var suggestions: [String] = []

    var selectedIndex: Int?

    private lazy var tableView: NSView = {
        NSHostingView(rootView: ListSelectionExample(onReturn: { value in
            self.selectedIndex = value
        }))
    }()

    convenience init() {
        let window = NSWindow(contentViewController: NSViewController())
        window.styleMask = .borderless
        window.contentView = NSView()

        self.init(window: window)

        guard let contentView = window.contentView else { return }
        contentView.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func orderOut() {
        window?.orderOut(nil)
    }

    func showSuggestions(_ suggestions: [String], for textField: NSTextField) {
        if suggestions.isEmpty {
            orderOut()
        } else {
            self.suggestions = suggestions
            guard let textFieldWindow = textField.window, let window = self.window else { return }
            var textFieldRect = textField.convert(textField.bounds, to: nil)
            textFieldRect = textFieldWindow.convertToScreen(textFieldRect)
            textFieldRect.origin.y -= 5
            window.setFrameTopLeftPoint(textFieldRect.origin)

            var frame = window.frame
            frame.size.width = textField.frame.width
            window.setFrame(frame, display: false)
            textFieldWindow.addChildWindow(window, ordered: .above)
        }
    }
}
