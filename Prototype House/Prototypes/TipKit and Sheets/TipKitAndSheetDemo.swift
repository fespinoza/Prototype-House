import SwiftUI
import TipKit

struct SampleTip: Tip {
    @Parameter(.transient) static var isReadyToRender: Bool = false

    var title: Text { Text("This is how tips work") }

    var rules: [Rule] {
        [
            #Rule(Self.$isReadyToRender) { $0 == true }
        ]
    }
}

struct OtherTip: Tip {
    var title: Text { Text("This is to style tips #1") }
}

struct ThirdTip: Tip {
    var title: Text { Text("This is to style tips #2") }
}

struct TipKitAndSheetDemo: View {
    @State var showSheet = true
    @State var showElement = false

    var body: some View {
        VStack(spacing: 30) {
            Text("Hello, World!")

            if showElement {
                HiddenContent()
            }

            Button("Reset", action: { withAnimation { showElement = false } })

            Button("Sheet", action: { withAnimation { showSheet = true } })

            Spacer()
        }
        .sheet(isPresented: $showSheet) {
            SampleTip.isReadyToRender = true
        } content: {
            NavigationStack {
                SheetContent(showElement: $showElement)
            }
            .presentationDetents([.medium])
        }
    }

    struct HiddenContent: View {
        let tip = SampleTip()
        @State var count: Int = 0

        var body: some View {
            HStack {
                Text("My element: \(count)")

                Spacer()

                Text("Cool")
                    .popoverTip(tip)
            }
            .padding()
            .background(Color.blue.opacity(0.3))
            .onTapGesture {
                count += 1
            }
        }
    }

    struct SheetContent: View {
        @Binding var showElement: Bool
        @Environment(\.dismiss) var dismiss

        let tip = OtherTip()
        let thirdTip = ThirdTip()

        var body: some View {
            VStack(spacing: 30) {
                Text("Sheet content")

                Button("Show Element", action: doStuff)
                    .popoverTip(tip)
                    .tipViewStyle(MyTipStyle())
                    .tipBackground(Color.orange)

                TipView(ThirdTip())
//                    .tipBackground(Color.red)
                    .tipViewStyle(MyTipStyle())
                    .padding()

            }
//            .tipBackground(Color.blue)
            .navigationTitle("Sheet")
        }

        func doStuff() {
            withAnimation { showElement = true }
            dismiss()
        }
    }
}

struct MyTipStyle: TipViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            if let image = configuration.image {
                image
                    .font(.title2)
                    .foregroundStyle(.green)
            }
            if let title = configuration.title {
                title
                    .bold()
                    .font(.headline)
                    .textCase(.uppercase)
            }
            if let message = configuration.message {
                message
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .backgroundStyle(.thinMaterial)
        .overlay(alignment: .topTrailing) {
            // Close Button
            Image(systemName: "multiply")
                .font(.title2)
                .alignmentGuide(.top) { $0[.top] - 5 }
                .alignmentGuide(.trailing) { $0[.trailing] + 5 }
                .foregroundStyle(.secondary)
                .onTapGesture {
                    // Invalidate Reason
                    configuration.tip.invalidate(reason: .tipClosed)
                }
        }
        .padding()
    }
}

#Preview {
    TipKitAndSheetDemo()
        .task {
            try? Tips.resetDatastore()
            try? Tips.configure()
        }
}
