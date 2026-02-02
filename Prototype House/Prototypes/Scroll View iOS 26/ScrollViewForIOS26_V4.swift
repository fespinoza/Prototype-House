import SwiftUI

// No title variant

struct SlackNavBarViewModifier: ViewModifier {
    @State var offsetY: CGFloat = 0
    @State var initialOffsetY: CGFloat = 0
    let customBarBackgroundHeight: CGFloat = 400

    let color: Color

    init(color: Color = .blue) {
        self.color = color
    }

    var barOffset: CGFloat {
        -(initialOffsetY + offsetY) - customBarBackgroundHeight / 2
    }

    func body(content: Content) -> some View {
        ZStack {
            VStack(spacing: 0) {
                color
                    .frame(height: customBarBackgroundHeight)
                    .offset(y: barOffset)
                    .ignoresSafeArea(.container, edges: .top)

                Color.clear
            }

            content
                .onScrollGeometryChange(
                    for: CGFloat.self,
                    of: { $0.contentOffset.y },
                    action: { _, newValue in
                        offsetY = newValue
                        if initialOffsetY == 0 {
                            initialOffsetY = -newValue
                        }
                    }
                )
        }
//        .overlay {
//            Text("\(offsetY)\n\(barOffset)\n\(initialOffsetY)")
//                .monospacedDigit()
//                .padding()
//                .background(Color.red)
//                .offset()
//        }
        .onGeometryChange(
            for: CGFloat.self,
            of: { $0.size.width },
            action: { oldValue, newValue in
                if oldValue != newValue {
                    initialOffsetY = 0
                }
            }
        )
        .toolbarTitleDisplayMode(.inline)
        .toolbarBackground(.clear, for: .navigationBar)
    }
}

private extension View {
    func slackNavBar() -> some View {
        modifier(SlackNavBarViewModifier())
    }
}

@available(iOS 26.0, *)
struct ScrollViewForIOS26_V4: View {
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    Color(uiColor: .lightGray)
                        .frame(height: 400)

                    Color.white
                        .frame(height: 2000)
                }
            }
            .slackNavBar()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Circle()
                        .foregroundStyle(Color(uiColor: .black))
                        .overlay {
                            Text("S")
                                .foregroundStyle(.white)
                        }
                }

                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: {}) {
                        Label("Filter", systemImage: "line.horizontal.3.decrease")
                    }

                    Button(action: {}) {
                        Label("Filter", systemImage: "person.circle")
                    }
                }
            }
        }
    }
}

@available(iOS 26.0, *)
#Preview {
    ScrollViewForIOS26_V4()
}
