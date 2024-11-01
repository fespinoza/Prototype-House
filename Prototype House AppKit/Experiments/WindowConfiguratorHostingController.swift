//
//  WindowConfiguratorHostingController.swift
//  Prototype House AppKit
//
//  Created by Felipe Espinoza on 16/06/2024.
//

import Cocoa
import SwiftUI

class WindowConfiguratorHostingController: NSViewController {
    struct SampleContent: View {
        @Environment(\.dismissWindow) var dismissWindow
        let debugDescription: String

        var body: some View {
            VStack {
                Spacer()
                Text("Sample content")
                Text(debugDescription)
                Spacer()

                Button(action: { dismissWindow() }) {
                    Text("Close")
                }
            }
            .padding()
            .frame(minWidth: 300, minHeight: 300)
            .background(Material.thin)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }


    lazy var hostingController: NSHostingController = {
        let controller = NSHostingController(rootView: WindowConfiguratorView(onOpenWindow: openTemplateWindow))
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        return controller
    }()

    func openTemplateWindow(_ input: WindowConfiguratorView.Input) {
        let windowContent = NSHostingController(
            rootView: SampleContent(
                debugDescription: input.windowMaskSettings.debugDescription
            )
        )

        windowContent.view.layer?.cornerRadius = 16

        let window = NSWindow(contentViewController: windowContent)
        window.setContentSize(NSSize(width: 380, height: 400))
        window.title = input.title
        window.styleMask = input.windowMaskSettings.finalValue
        window.isMovableByWindowBackground = true

        let templateWindow = TemplateWindowController(window: window)

        templateWindow.showWindow(nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.

        view.addSubview(hostingController.view)
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}
