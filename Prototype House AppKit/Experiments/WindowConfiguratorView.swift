//
//  WindowConfiguratorView.swift
//  Prototype House AppKit
//
//  Created by Felipe Espinoza on 16/06/2024.
//

import SwiftUI

//https://github.com/lukakerr/NSWindowStyles

struct WindowConfiguratorView: View {
    enum SupportedWindowStyle: String, Hashable, CaseIterable {
        case borderless
        case titled
        case closable
        case miniaturizable
        case resizable
        case unifiedTitleAndToolbar
        case fullScreen
        case fullSizeContentView
        case utilityWindow
        case docModalWindow
        case nonactivatingPanel
        case hudWindow

        var windowStyle: NSWindow.StyleMask {
            switch self {
            case .borderless: .borderless
            case .titled: .titled
            case .closable: .closable
            case .miniaturizable: .miniaturizable
            case .resizable: .resizable
            case .unifiedTitleAndToolbar: .unifiedTitleAndToolbar
            case .fullScreen: .fullScreen
            case .fullSizeContentView: .fullSizeContentView
            case .utilityWindow: .utilityWindow
            case .docModalWindow: .docModalWindow
            case .nonactivatingPanel: .nonactivatingPanel
            case .hudWindow: .hudWindow
            }
        }
    }

    struct WindowMaskSettings {
        var borderless: Bool = false
        var titled: Bool = true
        var closable: Bool = true
        var miniaturizable: Bool = true
        var resizable: Bool = true
        var unifiedTitleAndToolbar: Bool = false
        var fullScreen: Bool = false
        var fullSizeContentView: Bool = false
        var utilityWindow: Bool = false
        var docModalWindow: Bool = false
        var nonactivatingPanel: Bool = false
        var hudWindow: Bool = false

        var finalValue: NSWindow.StyleMask {
            var result: NSWindow.StyleMask = []

            if borderless {
                result = result.union(SupportedWindowStyle.borderless.windowStyle)
            }

            if titled {
                result = result.union(SupportedWindowStyle.titled.windowStyle)
            }
            if closable {
                result = result.union(SupportedWindowStyle.closable.windowStyle)
            }
            if miniaturizable {
                result = result.union(SupportedWindowStyle.miniaturizable.windowStyle)
            }
            if resizable {
                result = result.union(SupportedWindowStyle.resizable.windowStyle)
            }
            if unifiedTitleAndToolbar {
                result = result.union(SupportedWindowStyle.unifiedTitleAndToolbar.windowStyle)
            }
            if fullScreen {
                result = result.union(SupportedWindowStyle.fullScreen.windowStyle)
            }
            if fullSizeContentView {
                result = result.union(SupportedWindowStyle.fullSizeContentView.windowStyle)
            }
            if utilityWindow {
                result = result.union(SupportedWindowStyle.utilityWindow.windowStyle)
            }
            if docModalWindow {
                result = result.union(SupportedWindowStyle.docModalWindow.windowStyle)
            }
            if nonactivatingPanel {
                result = result.union(SupportedWindowStyle.nonactivatingPanel.windowStyle)
            }
            if hudWindow {
                result = result.union(SupportedWindowStyle.hudWindow.windowStyle)
            }
            return result
        }

        var debugDescription: String {
            var result: [String] = []

            if borderless {
                result.append(SupportedWindowStyle.borderless.rawValue)
            }
            if titled {
                result.append(SupportedWindowStyle.titled.rawValue)
            }
            if closable {
                result.append(SupportedWindowStyle.closable.rawValue)
            }
            if miniaturizable {
                result.append(SupportedWindowStyle.miniaturizable.rawValue)
            }
            if resizable {
                result.append(SupportedWindowStyle.resizable.rawValue)
            }
            if unifiedTitleAndToolbar {
                result.append(SupportedWindowStyle.unifiedTitleAndToolbar.rawValue)
            }
            if fullScreen {
                result.append(SupportedWindowStyle.fullScreen.rawValue)
            }
            if fullSizeContentView {
                result.append(SupportedWindowStyle.fullSizeContentView.rawValue)
            }
            if utilityWindow {
                result.append(SupportedWindowStyle.utilityWindow.rawValue)
            }
            if docModalWindow {
                result.append(SupportedWindowStyle.docModalWindow.rawValue)
            }
            if nonactivatingPanel {
                result.append(SupportedWindowStyle.nonactivatingPanel.rawValue)
            }
            if hudWindow {
                result.append(SupportedWindowStyle.hudWindow.rawValue)
            }
            return result.joined(separator: ",")
        }

        func keypath(for style: SupportedWindowStyle) -> WritableKeyPath<WindowMaskSettings, Bool> {
            switch style {
            case .borderless: \.borderless
            case .titled: \.titled
            case .closable: \.closable
            case .miniaturizable: \.miniaturizable
            case .resizable: \.resizable
            case .unifiedTitleAndToolbar: \.unifiedTitleAndToolbar
            case .fullScreen: \.fullScreen
            case .fullSizeContentView: \.fullSizeContentView
            case .utilityWindow: \.utilityWindow
            case .docModalWindow: \.docModalWindow
            case .nonactivatingPanel: \.nonactivatingPanel
            case .hudWindow: \.hudWindow
            }
        }
    }

    struct Input {
        var title: String = "Sample Window"
        var windowMaskSettings: WindowMaskSettings = .init()
    }

    var onOpenWindow: ((Input) -> Void)?

    @State var input: Input = .init()

    var body: some View {
        VStack {
            TextField("Window Title:", text: $input.title)

            VStack(alignment: .leading) {
                ForEach(SupportedWindowStyle.allCases, id: \.rawValue) { style in
                    Toggle(isOn: inputBinding(for: style), label: {
                        Text(style.rawValue)
                    })
                }
            }

            Button("Open Window", action: openWindow)
        }
        .padding()
    }

    func inputBinding(for style: SupportedWindowStyle) -> Binding<Bool> {
        .init {
            input.windowMaskSettings[
                keyPath: input.windowMaskSettings.keypath(for: style)
            ]
        } set: { newValue in
            input.windowMaskSettings[
                keyPath: input.windowMaskSettings.keypath(for: style)
            ] = newValue
        }

    }

    func openWindow() {
        onOpenWindow?(input)
    }
}

#Preview {
    WindowConfiguratorView()
        .frame(minWidth: 300, minHeight: 200)
}
