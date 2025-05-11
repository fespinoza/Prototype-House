import SwiftUI

enum ViewEdgeToTrack {
    case top
    case bottom
}

extension View {
    func monitorViewScrollOffset(
        in coordinateSpace: NamedCoordinateSpace,
        edge: ViewEdgeToTrack = .top,
        onChange: @escaping (CGFloat) -> Void
    ) -> some View {
        modifier(
            MonitoringViewScrollOffset(
                coordinateSpace: coordinateSpace,
                edge: edge,
                onChange: onChange
            )
        )
    }
}

private struct ViewOffsetKey: PreferenceKey {
    static let defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

private struct MonitoringViewScrollOffset: ViewModifier {
    let coordinateSpace: NamedCoordinateSpace
    let edge: ViewEdgeToTrack
    let onChange: (CGFloat) -> Void

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: ViewOffsetKey.self, value: offset(in: proxy))
                }
            )
            .onPreferenceChange(ViewOffsetKey.self, perform: onChange)
    }

    func offset(in geometryProxy: GeometryProxy) -> CGFloat {
        let frame = geometryProxy.frame(in: coordinateSpace)
        return edge == .top ? frame.minY : frame.maxY
    }
}

// MARK: - View Implementation

struct RefinedScrollViewElementTrackingPosition: View {
    @State private var targetPosition: CGFloat = 0
    private var scrollCoordinateSpace = NamedCoordinateSpace.named("scrollContent")

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<50) { i in
                    if i == 5 {
                        Color.red
                            .frame(height: 100)
                            .monitorViewScrollOffset(
                                in: scrollCoordinateSpace,
                                edge: .bottom,
                                onChange: { targetPosition = $0 }
                            )
                    } else {
                        Color.blue.opacity(0.3).frame(height: 50)
                    }
                }
            }
        }
        .coordinateSpace(scrollCoordinateSpace)
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
        RefinedScrollViewElementTrackingPosition()
            .navigationTitle("Scrollable Content")
    }
}
