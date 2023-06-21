//
//  ContentOnboardingSampleView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 28/02/2023.
//

import SwiftUI

@available(iOS 16.0, *)
struct ContentOnboardingSampleView: View {
    @State var pressedCount: Int = 0

    var body: some View {
        TabView {
            screenContent
                .overlay {
                    OnboardingOverlayView()
                }
                .tabItem {
                    Image(systemName: "rectangle")
                    Text("First")
                }

            Color.red
                .tabItem {
                    Image(systemName: "circle.fill")
                    Text("Second")
                }

            Color.green
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Third")
                }
        }
    }

    var screenContent: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image("london")
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                Text("Hello, World!")

                Button(action: { pressedCount += 1 }) {
                    Text("Press me")
                }
                .buttonStyle(.borderedProminent)

                Text("Press count: \(pressedCount)")

                Spacer()
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "trash")
                }
            })
            .navigationTitle("London")
        }
    }
}

@available(iOS 16.0, *)
struct ContentOnboardingSampleView_Previews: PreviewProvider {
    static var previews: some View {
        ContentOnboardingSampleView()
    }
}
