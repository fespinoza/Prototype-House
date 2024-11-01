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

//    @State var selection: NewListContent.Element?
    let viewModel: NewListContent.ViewModel = .init()

    var selectedElement: NewListContent.Element? {
        viewModel.selectedCell
    }

    private lazy var swiftUIContent: NSView = {
        let view = NSHostingView(rootView: NewListContent(viewModel: viewModel).frame(height: 200))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    convenience init() {
        let window = NSWindow(contentViewController: NSViewController())
        window.styleMask = .borderless
        window.contentView = NSView()

        self.init(window: window)

        guard let contentView = window.contentView else { return }
        contentView.addSubview(swiftUIContent)
        NSLayoutConstraint.activate([
            swiftUIContent.topAnchor.constraint(equalTo: contentView.topAnchor),
            swiftUIContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            swiftUIContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            swiftUIContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        window?.contentView?.layer?.cornerRadius = 16
    }

    func orderOut() {
        window?.orderOut(nil)
    }

    func showSuggestions(_ suggestions: [String], for textField: NSTextField) {
        if suggestions.isEmpty {
            orderOut()
        } else {
//            self.suggestions = suggestions
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

    func moveUp() {
        viewModel.selectPrevious()
    }

    func moveDown() {
        viewModel.selectNext()
    }
}
