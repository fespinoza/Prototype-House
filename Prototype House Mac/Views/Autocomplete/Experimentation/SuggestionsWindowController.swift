// originally taken from: https://github.com/lucasderraugh/AppleProg-Cocoa-Tutorials/blob/master/Lesson%2090/CustomSearchSuggestionsWindow/SuggestionsWindowController.swift

import Cocoa
import SwiftUI

class SuggestionsWindowControllerExp: NSWindowController {

    private var suggestions: [String] = []

    var selectedIndex: Int?

    private lazy var tableView: NSTableView = {
        let t = NSTableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.addTableColumn(NSTableColumn(identifier: NSUserInterfaceItemIdentifier("Main")))
        t.usesAutomaticRowHeights = true
//        t.register(TableCellView.nib, forIdentifier: TableCellView.identifier)
        t.dataSource = self
        t.delegate = self
        return t
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

//    override func windowDidLoad() {
//        super.windowDidLoad()
//
//        guard let contentView = window?.contentView else { return }
//
//        contentView.addSubview(tableView)
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
//    }

    func orderOut() {
        tableView.deselectAll(nil)
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

            tableView.reloadData()
        }
    }

    func moveUp() {
        let selectedRow = max(tableView.selectedRow - 1, 0)
        tableView.selectRowIndexes(IndexSet(integer: selectedRow), byExtendingSelection: false)
    }

    func moveDown() {
        let selectedRow = min(tableView.selectedRow + 1, suggestions.count - 1)
        tableView.selectRowIndexes(IndexSet(integer: selectedRow), byExtendingSelection: false)
    }

    var currentSuggestion: String? {
        let selectedRow = tableView.selectedRow
        return selectedRow == -1 ? nil : suggestions[selectedRow]
    }
}

extension SuggestionsWindowControllerExp: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return suggestions.count
    }
}
//
extension SuggestionsWindowControllerExp: NSTableViewDelegate {
//    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
//        guard let view = tableView.makeView(withIdentifier: TableCellView.identifier, owner: self) as? TableCellView else { return nil }
//        view.textField?.stringValue = suggestions[row]
//        return view
//    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        print(#function, tableColumn, row)
        let view = NSTextField(labelWithString: suggestions[row])
        view.backgroundColor = .red
        return view
    }
}
