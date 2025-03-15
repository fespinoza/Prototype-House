import SwiftUI

struct ContentView: View {
    @State var text: String?

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(text ?? "Hello, world!")

            Menu {
                Button("Option #1", action: { text = "Option #1" })
                Button("Option #2", action: { text = "Option #2" })
            } label: {
                Label("Hello", systemImage: "swift")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
