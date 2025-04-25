import SwiftUI

struct ScrollViewElementPositionDemo: View {
    @State private var targetPosition: CGFloat = 0
    @State private var targetHeight: CGFloat = 0
    @State private var contentHeight: CGFloat = 1 // Avoid division by zero

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<50) { i in
                    if i == 5 {
                        // The view we want to track
                        Color.red
                            .frame(height: 100)
                            .overlay(
                                GeometryReader { geo in
                                    Text("Tracking me! - \(geo.size)").monospacedDigit()
                                        .onAppear {
                                            targetHeight = geo.size.height
                                        }
                                }
                            )
                            .background(
                                GeometryReader { geo in
                                    Color.clear
                                        .preference(key: ViewOffsetKey.self, value: geo.frame(in: .named("scroll")).maxY)
                                }
                            )
                    } else {
                        Color.blue.frame(height: 50)
                    }
                }
            }
            .background(
                GeometryReader { geo in
                    Color.clear
                        .preference(key: ContentHeightKey.self, value: geo.size.height)
                }
            )
        }
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(ViewOffsetKey.self) { value in
            targetPosition = value
        }
        .onPreferenceChange(ContentHeightKey.self) { height in
            contentHeight = height
        }
        .overlay(alignment: .topLeading) {
            Text(String(format: "Target Position: %.2f", targetPosition)).monospacedDigit()
                .padding()
                .background(Color.white)
        }
        .overlay(alignment: .bottom) {
            Text("Content not on screen! - \(targetHeight)")
                .monospacedDigit()
                .padding()
                .background(Color.white)
                .opacity(optionalContentOpacity(targetPosition))
                .offset(x: 0, y: optionalContentOffset(targetPosition))
        }
    }

    // Preference keys
    struct ViewOffsetKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }

    struct ContentHeightKey: PreferenceKey {
        static var defaultValue: CGFloat = 1
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }

    var optionalContentOffset = LinearEquation.segmentedLinearEquation(
        fromPoint: CGPoint(x: -20, y: 0),
        toPoint: CGPoint(x: 0, y: 100)
    )

    var optionalContentOpacity = LinearEquation.segmentedLinearEquation(
        fromPoint: CGPoint(x: -20, y: 1.0),
        toPoint: CGPoint(x: 0, y: 0)
    )
}

#Preview {
    NavigationStack {
        ScrollViewElementPositionDemo()
            .navigationTitle("Scrollable Content")
    }
}
