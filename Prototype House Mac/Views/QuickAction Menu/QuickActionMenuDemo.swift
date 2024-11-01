//
//  QuickActionMenuDemo.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 26/06/2024.
//

import SwiftUI

// Xcode Quick Action menu is not a sheet

struct QuickActionMenuDemo: View {
    @State var isShowingCommand: Bool = false
    @State var search: String = ""
    @State var selectedText: String?

    @State var selectedOption: String?
    var options: [String] {
        guard !search.isEmpty else { return [] }

        return [
            "One",
            "Two",
            "Three",
            "Four",
            "Five",
        ].filter { $0.lowercased().contains(search.lowercased()) }
    }

    var body: some View {
        VStack {
            Text("Hello, World! \(selectedText ?? "")")

            Button("Help", action: { isShowingCommand.toggle() })
                .keyboardShortcut(KeyEquivalent("a"), modifiers: .command)
        }
        .sheet(isPresented: $isShowingCommand, content: {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search...", text: $search)
                        .textFieldStyle(.plain)
                }
                if !options.isEmpty {
                    // List is a scroll view
                    List(options, id: \.self, selection: $selectedOption) { option in
                        Text(option).onTapGesture(perform: {
                            selectedOption = option
                            selectedText = option
                            isShowingCommand = false
                        })
                        .frame(height: 20)
                    }
                    .frame(height: 40 * CGFloat(options.count))
                }
            }
            // how to have it one size when the text is empty
            // how to have it larger ✅

            // how to grow from top to bottom?
            .padding()
            .frame(width: 400)
//            .frame(width: 400, height: 200)
//            .frame(minHeight: 50)
//            .fixedSize(horizontal: false, vertical: true)
        })
        .frame(width: 600, height: 400)
    }
}

#Preview {
    QuickActionMenuDemo()
}
