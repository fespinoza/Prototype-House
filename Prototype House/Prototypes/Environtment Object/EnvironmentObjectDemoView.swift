//
//  EnvironmentObjectDemoView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 18/10/2023.
//

import SwiftUI

class SomeViewModel: ObservableObject {
    @Published var count: Int = 0
}

@available(iOS 16.0, *)
struct EnvironmentObjectDemoView: View {
    @StateObject var someViewModel: SomeViewModel = .init()

    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Nested #1") {
                    NestedView()
                        .navigationTitle("Nested #1")
                }

                NavigationLink("Nested #2") {
                    NestedView()
                        .navigationTitle("Nested #2")
                }

                NavigationLink("Nested #3 - Container") {
                    ContainerView()
                        .navigationTitle("Nested #3")
                }
            }
            .navigationTitle("EnvironmentObject")
        }
        .environmentObject(someViewModel)
    }
}

@available(iOS 16.0, *)
extension EnvironmentObjectDemoView {
    struct NestedView: View {
        @EnvironmentObject var other: SomeViewModel

        var body: some View {
            VStack {
                Text(other.count.formatted())

                Button("add", action: { other.count += 1 })

                Text("it works!")
            }
        }
    }

    struct ContainerView: View {
        var body: some View {
            VStack {
                Text("Container").font(.largeTitle)

                EnvironmentObjectDemoView.NestedView()
            }
        }
    }
}

@available(iOS 16.0, *)
#Preview {
    EnvironmentObjectDemoView()
}
