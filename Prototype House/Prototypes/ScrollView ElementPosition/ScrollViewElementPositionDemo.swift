import SwiftUI

private struct ViewOffsetKey: PreferenceKey {
    static let defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct ScrollViewElementPositionDemo: View {
    @State private var targetPosition: CGFloat = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<50) { i in
                    if i == 5 {
                        Color.red
                            .frame(height: 100)
                            .background(
                                GeometryReader { proxy in
                                    Color.clear
                                        .preference(
                                            key: ViewOffsetKey.self,
                                            value: proxy.frame(in: .named("scrollContent")).maxY
                                        )
                                }
                            )
                    } else {
                        Color.blue.opacity(0.3).frame(height: 50)
                    }
                }
            }
        }
        .coordinateSpace(.named("scrollContent"))
        .onPreferenceChange(ViewOffsetKey.self) { newValue in
            targetPosition = newValue
        }
        .overlay(alignment: .topLeading) {
            Text(String(format: "Target Position: %.2f", targetPosition)).monospacedDigit()
                .padding()
                .background(Color.white)
        }
        .overlay(alignment: .bottom) {
            extraContent
                .opacity(extraContentOpacity(targetPosition))
                .offset(x: 0, y: extraContentOffset(targetPosition))
        }
    }

    var extraContentOpacity = LinearEquation.segmentedLinearEquation(
        fromPoint: .init(x: -20, y: 1.0),
        toPoint: .init(x: 0, y: 0)
    )

    var extraContentOffset = LinearEquation.segmentedLinearEquation(
        fromPoint: .init(x: -20, y: 0),
        toPoint: .init(x: 0, y: 100)
    )

    var extraContent: some View {
        Text("Tracked content not on screen!")
            .monospacedDigit()
            .padding(24)
            .frame(maxWidth: .infinity)
            .background(Color.yellow)
            .cornerRadius(8)
            .shadow(radius: 4)
            .padding()
    }
}

#Preview {
    NavigationStack {
        ScrollViewElementPositionDemo()
            .navigationTitle("Scrollable Content")
    }
}
