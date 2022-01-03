//
//  ContentView.swift
//  Prototype House Mac
//
//  Created by Felipe Espinoza on 03/01/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(1...10, id: \.self) { index in
                NavigationLink(
                    "Item \(index)",
                    destination: { DetailView(index: index) }
                )
            }
            .toolbar {
                ToolbarItem {
                    Button(action: toggleSidebar) {
                        Image(systemName: "sidebar.leading")
                    }
                }
            }

            DetailView(index: nil)
        }
    }

    func toggleSidebar() {
        NSApp
            .keyWindow?
            .firstResponder?
            .tryToPerform(
                #selector(NSSplitViewController.toggleSidebar(_:)),
                with: nil
            )
    }
}

struct DetailView: View {
    let index: Int?

    var body: some View {
        Group {
            if let index = index {
                DetailContentView(index: index)
            } else {
                Text("Hello World")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
