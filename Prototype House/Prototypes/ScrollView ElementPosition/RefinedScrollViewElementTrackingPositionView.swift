import SwiftUI

enum MonitorEdge {
    case top
    case bottom
}

extension View {
    func monitorPositionAndSize(
        in coordinateSpace: NamedCoordinateSpace,
        edge: MonitorEdge = .top,
        onChange: @escaping (MonitorGeometry) -> Void
    ) -> some View {
        modifier(MonitoringView(coordinateSpace: coordinateSpace, edge: edge, onChange: onChange))
    }
}

struct MonitoringView: ViewModifier {
    let coordinateSpace: NamedCoordinateSpace
    let edge: MonitorEdge
    let onChange: (MonitorGeometry) -> Void

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: MonitorViewOffsetKey.self, value: geometry(in: proxy))
                }
            )
            .onPreferenceChange(MonitorViewOffsetKey.self, perform: onChange)
    }

    func geometry(in geometryProxy: GeometryProxy) -> MonitorGeometry {
        .init(
            offset: offset(in: geometryProxy),
            size: geometryProxy.size
        )
    }

    func offset(in geometryProxy: GeometryProxy) -> CGFloat {
        let frame = geometryProxy.frame(in: coordinateSpace)
        return edge == .top ? frame.minY : frame.maxY
    }
}

struct MonitorGeometry: Hashable {
    let offset: CGFloat
    let size: CGSize
}

struct MonitorViewOffsetKey: PreferenceKey {
    static var defaultValue: MonitorGeometry = .init(offset: 0, size: .zero)
    static func reduce(value: inout MonitorGeometry, nextValue: () -> MonitorGeometry) {
        value = nextValue()
    }
}

struct RefinedScrollViewElementTrackingPositionView: View {
    @State private var targetPosition: CGFloat = 0
    @State private var targetHeight: CGFloat = 0
    private var scrollCoordinateSpace = NamedCoordinateSpace.named("scroll")

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<50) { i in
                    if i == 5 {
                        // The view we want to track
                        Color.orange
                            .frame(height: 100)
                            .monitorPositionAndSize(in: scrollCoordinateSpace, edge: .bottom) { value in
                                targetPosition = value.offset
                                targetHeight = value.size.height
                            }
                    } else {
                        Color.blue.frame(height: 50)
                    }
                }
            }
        }
        .navigationTitle("Cleaner Example")
        .coordinateSpace(scrollCoordinateSpace)
        .overlay(alignment: .topLeading) {
            VStack {
                Text(String(format: "Target Position: %.2f", targetPosition)).monospacedDigit()
                Text(String(format: "Offset: %.2f", optionalContentOffset(targetPosition))).monospacedDigit()
            }
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

    @State var optionalContentOffset = LinearEquation.segmentedLinearEquation(
        fromPoint: CGPoint(x: -20, y: 0),
        toPoint: CGPoint(x: 0, y: 20)
    )

    @State var optionalContentOpacity = LinearEquation.segmentedLinearEquation(
        fromPoint: CGPoint(x: -20, y: 1.0),
        toPoint: CGPoint(x: 0, y: 0)
    )
}

#Preview {
    NavigationStack {
        RefinedScrollViewElementTrackingPositionView()
    }
}
