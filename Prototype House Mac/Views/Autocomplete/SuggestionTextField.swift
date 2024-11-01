import SwiftUI
import Combine

extension SuggestionTextField where Content == TextSuggestion {
    init(
        _ title: String,
        text: Binding<String>,
        suggestionData: [String],
        onSelection: ((Content) -> Void)? = nil
    ) {
        self.title = title
        self._text = text
        self.suggestionData = suggestionData.map { TextSuggestion(stringLiteral: $0) }
        self.onSelection = onSelection
    }
}

struct SuggestionTextField<Content: SuggestionContent>: NSViewRepresentable {
    let title: String
    @Binding var text: String
    let suggestionData: [Content]
    var onSelection: ((Content) -> Void)?

    init(
        _ title: String,
        text: Binding<String>,
        suggestionData: [Content],
        onSelection: ((Content) -> Void)? = nil
    ) {
        self.title = title
        self._text = text
        self.suggestionData = suggestionData
        self.onSelection = onSelection
    }

    private let view = NSTextField()

    func makeNSView(context: Context) -> NSTextField {
        view.delegate = context.coordinator
        view.stringValue = text
        view.placeholderString = title
        return view
    }

    func updateNSView(_ textField: NSTextField, context: Context) {
        textField.stringValue = text
    }

    func makeCoordinator() -> TextCoordinator {
        TextCoordinator(
            textField: view,
            text: $text,
            suggestionData: suggestionData,
            onSelection: onSelection
        )
    }
}

extension SuggestionTextField {
    class TextCoordinator: NSObject, NSTextFieldDelegate {
        let textField: NSTextField
        let text: Binding<String>
        let suggestionData: [Content]
        var onSelection: ((Content) -> Void)?

        private let suggestionsController: SuggestionsWindowController<Content> = .init()

        init(
            textField: NSTextField,
            text: Binding<String>,
            suggestionData: [Content],
            onSelection: ((Content) -> Void)? = nil
        ) {
            self.textField = textField
            self.text = text
            self.suggestionData = suggestionData
            self.onSelection = onSelection
        }

        var filteredSuggestion: [Content] {
            guard !text.wrappedValue.isEmpty else { return [] }

            return suggestionData.filter { suggestion in
                suggestion.suggestionText.lowercased().contains(text.wrappedValue.lowercased())
            }
        }

        // MARK: - NSTextFieldDelegate

        func controlTextDidChange(_ obj: Notification) {
            text.wrappedValue = textField.stringValue
            print(#function, text.wrappedValue, filteredSuggestion)
            suggestionsController.showSuggestions(filteredSuggestion, for: textField)
        }

        func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
            if commandSelector == #selector(NSTextView.moveUp(_:)) {
                suggestionsController.moveUp()
                return true
            }
            
            if commandSelector == #selector(NSTextView.moveDown(_:)) {
                suggestionsController.moveDown()
                return true
            }
            
            if commandSelector == #selector(NSTextView.insertNewline(_:)) {
                guard let suggestion = suggestionsController.selectedElement else { return false }
                textField.stringValue = suggestion.suggestionText
                text.wrappedValue = suggestion.suggestionText
                suggestionsController.orderOut()
                onSelection?(suggestion)
                return true
            }
            
            if commandSelector == #selector(NSTextView.cancelOperation(_:)) {
                suggestionsController.orderOut()
                return true
            }
            
            return false
        }

        func controlTextDidEndEditing(_ obj: Notification) {
            suggestionsController.orderOut()
        }
    }
}

private class SuggestionsWindowController<Content: SuggestionContent>: NSWindowController {
    let viewModel: SuggestionListViewModel<Content> = .init()

    private lazy var swiftUIContent: NSView = {
        let view = NSHostingView(
            rootView: SuggestionListContent(viewModel: viewModel)
                .frame(height: 200)
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var selectedElement: Content? {
        viewModel.selectedElement
    }

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

    func showSuggestions(_ suggestions: [Content], for textField: NSTextField) {
        if suggestions.isEmpty {
            orderOut()
        } else {
            viewModel.suggestionData = suggestions
            guard 
                let textFieldWindow = textField.window,
                let window = self.window
            else { return }

            print("showing suggestions!")

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

protocol SuggestionContent: Identifiable & Hashable & Equatable {
    var suggestionText: String { get }
}

struct TextSuggestion: SuggestionContent, ExpressibleByStringLiteral {
    var suggestionText: String
    
    typealias StringLiteralType = String

    var id: String { suggestionText }

    init(stringLiteral value: String) {
        self.suggestionText = value
    }

    init(suggestionText: String) {
        self.suggestionText = suggestionText
    }
}

private class SuggestionListViewModel<Content: SuggestionContent>: ObservableObject {
    @Published var selectedElement: Content?
    @Published var suggestionData: [Content]

    init(selectedElement: Content? = nil, suggestionData: [Content] = []) {
        self.selectedElement = selectedElement
        self.suggestionData = suggestionData
    }

    func selectFirst() {
        selectedElement = suggestionData.first
    }

    func selectNext() {
        if let currentValue = selectedElement,
           let index = suggestionData.firstIndex(of: currentValue),
           index + 1 < suggestionData.count {
            selectedElement = suggestionData[index + 1]
        } else {
            selectedElement = suggestionData.first
        }
    }

    func selectPrevious() {
        if let currentValue = selectedElement,
           let index = suggestionData.firstIndex(of: currentValue),
           index - 1 >= 0 {
            selectedElement = suggestionData[index - 1]
        } else {
            selectedElement = suggestionData.last
        }
    }
}

private struct SuggestionListContent<Content: SuggestionContent>: View {
    @ObservedObject var viewModel: SuggestionListViewModel<Content>

    var body: some View {
        List(viewModel.suggestionData, selection: $viewModel.selectedElement) { element in
            Text(element.suggestionText)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 4)
                .padding(.vertical, 2)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(
                            element == viewModel.selectedElement ? AnyShapeStyle(.selection) : AnyShapeStyle(.clear))
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.selectedElement = element
                }
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .onAppear(perform: viewModel.selectFirst)
        .focusable()
        .focusEffectDisabled()
    }
}

#Preview {
    struct Demo: View {
        @State var text: String = "Hi"

        struct Element: SuggestionContent {
            let id = UUID()
            let title: String
            let value: Int

            var suggestionText: String { title }

            static let sampleElements: [Element] = [
                .init(title: "One", value: 1),
                .init(title: "Two", value: 2),
                .init(title: "Three", value: 3),
                .init(title: "Four", value: 4),
                .init(title: "Five", value: 5),
            ]
        }

        var body: some View {
            VStack {
                TextField("Hello", text: $text)
                SuggestionTextField("Hello", text: $text, suggestionData: Element.sampleElements, onSelection: { suggestion in
                    print("selected suggestion")
                })
            }
        }
    }

    return Demo()
}
