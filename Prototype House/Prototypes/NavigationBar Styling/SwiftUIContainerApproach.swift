//
//  SwiftUIContainerApproach.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 29/03/2025.
//

import SwiftUI

struct SwiftUIContainer<Content: View>: UIViewRepresentable {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    func makeUIView(context: Context) -> UIView {
        let hostingController = UIHostingController(rootView: content)
        hostingController.view.backgroundColor = .clear

        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.red
        ]

        hostingController.navigationItem.standardAppearance = appearance
        return hostingController.view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // No need to update the view manually, SwiftUI manages state updates
    }
}


private struct Demo: View {
    var body: some View {
        NavigationStack {
            SwiftUIContainer {
                SampleNavigationBarContentView.LongContent()
                    .navigationTitle("Hello")
            }
        }
    }
}

#Preview {
    Demo()
}
