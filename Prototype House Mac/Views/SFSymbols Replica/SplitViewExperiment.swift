//
//  SplitViewExperiment.swift
//  Prototype House Mac
//
//  Created by Felipe Espinoza on 03/01/2022.
//

import SwiftUI

class TestViewController: NSViewController {
    var backgroundColor: NSColor? {
        didSet {
            view.layer?.backgroundColor = backgroundColor?.cgColor
        }
    }

    var text: String? {
        didSet {
            guard let text = text else { return }
            label.stringValue = text
        }
    }

    init(backgroundColor: NSColor? = nil, text: String? = nil) {
        self.backgroundColor = backgroundColor
        self.text = text
        super.init(nibName: nil, bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var label: NSTextField = {
        let label = NSTextField(labelWithString: text ?? "Placeholder")
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func loadView() {
        view = NSView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = backgroundColor?.cgColor

        view.addSubview(label)
        label.centerInSuperview()
    }
}

struct SplitViewAdapter: NSViewControllerRepresentable {
    @Binding var openSidebar: Bool

    init(openSidebar: Binding<Bool>) {
        self._openSidebar = openSidebar
    }

    func makeNSViewController(context: Context) -> NSSplitViewController {
        let controller = NSSplitViewController()
        let contentItem = NSSplitViewItem(viewController: TestViewController(backgroundColor: .red))

        let sideBarItem = NSSplitViewItem(sidebarWithViewController: TestViewController(text: "Sidebar"))
        sideBarItem.minimumThickness = 300

        controller.splitViewItems = [contentItem, sideBarItem]
        return controller
    }

    func updateNSViewController(_ splitController: NSSplitViewController, context: Context) {
        let sidebarItem = splitController.splitViewItems[1]
        if sidebarItem.isCollapsed != openSidebar {
            splitController.toggleSidebar(nil)
        }
    }
}

struct SplitViewExperiment: View {
    @State var openSidebar: Bool = true

    var body: some View {
//        GeometryReader { proxy in
            SplitViewAdapter(openSidebar: $openSidebar)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { openSidebar.toggle() }) {
                        Image(systemName: "sidebar.trailing")
                    }
                }
            }
//                .frame(width: proxy.size.width, height: proxy.size.height)
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SplitViewDemo: View {
    let group: ContentData.Group

    var body: some View {
        SplitViewExperiment()
            .navigationTitle(group.title)
    }
}

struct SplitViewExperiment_Previews: PreviewProvider {
    static var previews: some View {
        SplitViewExperiment()
    }
}
