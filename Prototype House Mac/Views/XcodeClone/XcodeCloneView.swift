//
//  XcodeCloneView.swift
//  Prototype House Mac
//
//  Created by Felipe Espinoza on 18/06/2024.
//

import SwiftUI

struct XcodeCloneView: View {
    struct ContentType: Equatable, Hashable, Identifiable {
        let id = UUID()
        let title: String
        let description: String

        static let exampleData: [ContentType] = [
            .init(title: "One", description: "...."),
            .init(title: "Two", description: "...."),
            .init(title: "Three", description: "...."),
            .init(title: "Four", description: "...."),
            .init(title: "Five", description: "...."),
        ]
    }

    @State var selectedContent: ContentType?

    var body: some View {
        NavigationSplitView {
            List(ContentType.exampleData, selection: $selectedContent) { content in
                NavigationLink(content.title, value: content)
            }
        } detail: {
            if let selectedContent {
                ContentView(content: selectedContent)
            } else {
                Text("Empty View")
            }
        }
    }

    struct ContentView: View {
        let content: ContentType
        @State private var text: String = ""

        var body: some View {
            VStack {
                Text(content.title).font(.largeTitle)
                Text(content.description)
                TextField("Hello", text: $text)
            }
        }
    }
}

#Preview {
    XcodeCloneView()
}
