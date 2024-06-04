import SwiftUI

protocol ParametricNavigationViewActions {
//    func createView<MyDest: View>() -> MyDest
    func altCreateView() -> AnyView

    associatedtype Desti: View
    func createDestiny() -> Desti
}

struct ParametricNavigationView<Dest: View, Action: ParametricNavigationViewActions>: View {
    var param: (() -> Dest)?
    var actions: Action?

    func createView() -> some View {
        Text("Shadow")
    }

    @ViewBuilder func createIfFound() -> some View {
        if let param {
            param()
        } else {
            EmptyView()
        }
    }

    @ViewBuilder func createIfAction() -> some View {
        if let actions {
            actions.altCreateView()
        } else {
            EmptyView()
        }
    }

    var body: some View {
        VStack(spacing: 30) {
            Text("Hello, World!")

            NavigationLink(destination: { Text("Child") }) {
                Text("Link #1")
            }

            NavigationLink(destination: { createView() }) {
                Text("Link #2")
            }

            NavigationLink(destination: { createIfFound() }) {
                Text("Link #3")
            }

            if let actions {
                NavigationLink(destination: { actions.altCreateView() }) {
                    Text("Link #4")
                }

                NavigationLink(destination: { actions.createDestiny() }) {
                    Text("Link #5")
                }
            }
        }
        .navigationTitle("Hello")
    }
}


private class DestBuilder: ParametricNavigationViewActions {
    func createDestiny() -> Text {
        Text("It works")
    }
    
    typealias Desti = Text


    func altCreateView() -> AnyView {
        AnyView(Color.purple)
    }

    func altCreateView() -> any View {
        Color.yellow
    }

    //        func createView() -> Color {
    //            Color.orange
    //        }

    func createView() -> any View {
        Color.red
    }

    func createView() -> some View {
        Color.red
    }
}

@available(iOS 16.0, *)
#Preview {


    return NavigationStack {
        ParametricNavigationView(
            param: { Color.blue },
            actions: DestBuilder()
        )
    }
}
