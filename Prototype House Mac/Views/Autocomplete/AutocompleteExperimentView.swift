//
//  AutocompleteExperimentView.swift
//  Prototype House Mac
//
//  Created by Felipe Espinoza on 05/06/2024.
//

import SwiftUI
import Combine

struct TextFieldWrapper: NSViewRepresentable {
    @Binding var text: String

    let view = NSTextField()

    func makeNSView(context: Context) -> NSTextField {
        print(#function, text, view.stringValue)
        view.delegate = context.coordinator
        view.stringValue = text
        view.placeholderString = "Hey"
        return view
    }
    
    func updateNSView(_ nsView: NSTextField, context: Context) {
        print(#function, text, nsView.stringValue)
//        text = nsView.stringValue
    }
    
    typealias NSViewType = NSTextField

    class TextCoordinator: NSObject, NSTextFieldDelegate {
        let textField: NSTextField
        let text: Binding<String>
        var observations: Set<AnyCancellable> = []

//        let suggestions: SuggestionsWindowController = .init()
        let suggestions: SuggestionsWindowControllerAlt = .init()

        init(textField: NSTextField, text: Binding<String>) {
            self.textField = textField
            self.text = text
        }

        func controlTextDidChange(_ obj: Notification) {
            text.wrappedValue = textField.stringValue
            suggestions.showSuggestions(["one", "two"], for: textField)
        }

        func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {

//            print(#function, commandSelector)
//            if commandSelector == #selector(NSTextView.moveUp(_:)) {
////                suggestions.moveUp()
//                return true
//            }
//            if commandSelector == #selector(NSTextView.moveDown(_:)) {
////                suggestions.moveDown()
//                return true
//            }
//            if commandSelector == #selector(NSTextView.insertNewline(_:)) {
//                guard let suggestion = suggestions.currentSuggestion else { return false }
//                textField.stringValue = suggestion
//                text.wrappedValue = suggestion
//                suggestions.orderOut()
//                return true
//            }
//            if commandSelector == #selector(NSTextView.cancelOperation(_:)) {
//                suggestions.orderOut()
//                return true
//            }
//
            return false
        }

        func controlTextDidEndEditing(_ obj: Notification) {
            print(#function)
            suggestions.orderOut()
        }
    }

    func makeCoordinator() -> TextCoordinator {
        TextCoordinator(textField: view, text: $text)
    }
}

struct AutocompleteExperimentView: View {
    @State var text: String = ""

    var body: some View {
        VStack {
            TextFieldWrapper(text: $text)

            Divider()

            Text(text)

            Divider()

            TextField("Hello", text: $text)
        }
        .padding()
    }
}

#Preview {
    AutocompleteExperimentView()
        .frame(width: 300, height: 400)
}
